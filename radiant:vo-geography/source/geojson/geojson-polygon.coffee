class @GeoJSON.Polygon extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'GeoJSON.Polygon'
  # EJSON serializable fields
  fields: ->
    type: String
    coordinates: [[[Number]]]

  constructor: (data) ->
    data = {coordinates: @_convertCoordinatesToArrayFromData(data)}
    data.type = 'Polygon'

    super(data)
    Object.freeze(@)

  isPointInside: (point) ->
    results = []
    for polygonPoints in @coordinates
      results.push GeoJSON.Polygon.isPointInsidePolygonPoints(point, polygonPoints)
    return lodash.includes(results, true)

  _convertCoordinatesToArrayFromData: (data) ->
    coordinates = if data and data.coordinates then data.coordinates else data
    if not coordinates or not lodash.isArray(coordinates) or lodash.isEmpty(coordinates)
      throw new Error(GeoJSON.Polygon.ERRORS.invalidCoordinates)

    convertedArray = []
    for polygon in coordinates
      pointsInPolygon = []
      for pointCords in polygon
        unless Coordinates.is(pointCords)
          pointCords = new Coordinates(pointCords)

        pointsInPolygon.push pointCords.toArray()
      convertedArray.push pointsInPolygon

    return convertedArray

  @_geolib: geolib
  @isPointInsidePolygonPoints: (point, polygonPoints) ->
    unless @isValidGeoJSONPoint(point)
      throw new Error(@ERRORS.invalidGeoJSONPoint)

    pointCoordinates = new Coordinates(point.coordinates).toObject()

    polygonCoordinates = []
    for point in polygonPoints
      polygonCoordinates.push new Coordinates(point).toObject()
    @_geolib.isPointInside(pointCoordinates, polygonCoordinates)
  @isValidGeoJSONPoint: (point) -> GeoJSON.Point.is(point)
  @ERRORS:
    invalidCoordinates: 'Invalid coordinates data for GeoJSON.Polygon'

GeoJSON.addGeometery('Polygon', GeoJSON.Polygon)
GeoJSON.isPolygon = (polygon) -> GeoJSON.Polygon.is(polygon)
