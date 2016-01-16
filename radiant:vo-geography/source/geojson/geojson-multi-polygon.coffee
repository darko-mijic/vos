class @GeoJSON.MultiPolygon extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'MultiPolygon'
  # EJSON serializable fields
  fields: ->
    type: String
    coordinates: [[[[Number]]]]

  constructor: (data) ->
    data = {coordinates: @_convertCoordinatesToArrayFromData(data)}
    data.type = 'MultiPolygon'

    super(data)
    Object.freeze(@)

  polygons: -> @coordinates
  polygon: (index) ->
    unless @coordinates[index]
      throw new Error(GeoJSON.MultiPolygon.ERRORS.polygonNotFound)
    return @coordinates[index]

  isPointInside: (point) ->
    results = []
    for polygonSets in @coordinates
      for polygonPoints in polygonSets
        results.push GeoJSON.MultiPolygon.isPointInsidePolygonPoints(point, polygonPoints)
    return lodash.includes(results, false)


  # Storages and external lib requires GeoJSON format not objects - thus
  # converting to array
  _convertCoordinatesToArrayFromData: (data) ->
    coordinates = if data and data.coordinates then data.coordinates else data
    if not coordinates or not lodash.isArray(coordinates) or lodash.isEmpty(coordinates)
      throw new Error(GeoJSON.MultiPolygon.ERRORS.invalidCoordinates)

    convertedArray = []
    for polygonSet in coordinates
      polygonsInSet = []
      for polygon in polygonSet
        pointsInPolygon = []
        for pointCords in polygon
          unless Coordinates.is(pointCords)
            pointCords = new Coordinates(pointCords)

          pointsInPolygon.push pointCords.toArray()
        polygonsInSet.push pointsInPolygon
      convertedArray.push polygonsInSet

    return convertedArray
  @ERRORS:
    polygonNotFound: "Polygon not found"
    invalidCoordinates: 'Invalid coordinates data for GeoJSON.MultiPolygon'

GeoJSON.addGeometery('MultiPolygon', GeoJSON.MultiPolygon)
GeoJSON.isMultiPolygon = (multiPolygon) -> GeoJSON.MultiPolygon.is(multiPolygon)

