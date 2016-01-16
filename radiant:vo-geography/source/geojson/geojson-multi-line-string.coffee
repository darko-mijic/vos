class @GeoJSON.MultiLineString extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'GeoJSON.MultiLineString'
  # EJSON serializable fields
  fields: ->
    type: String
    coordinates: [[[Number]]]

  constructor: (data) ->
    data = {coordinates: @_convertCoordinatesToArrayFromData(data)}
    data.type = 'MultiLineString'

    super(data)
    Object.freeze(@)

  _convertCoordinatesToArrayFromData: (data) ->
    coordinates = if data and data.coordinates then data.coordinates else data
    if not coordinates or not lodash.isArray(coordinates) or lodash.isEmpty(coordinates)
      throw new Error(GeoJSON.MultiLineString.ERRORS.invalidCoordinates)

    convertedArray = []
    for line in coordinates
      pointsInLine = []
      for pointCords in line
        unless Coordinates.is(pointCords)
          pointCords = new Coordinates(pointCords)

        pointsInLine.push cords.toArray()
      convertedArray.push pointsInLine

    return convertedArray

  line: (index) ->
    unless @coordinates[index]
      throw new Error(GeoJSON.MultiLineString.ERRORS.lineNotFound)
    return @coordinates[index]
  @ERRORS:
    lineNotFound: "Line not found"
    invalidCoordinates: 'Invalid coordinates data for GeoJSON.MultiLineString'

GeoJSON.addGeometery('MultiLineString', GeoJSON.MultiLineString)
GeoJSON.isMultiLineString = (multiLineString) -> GeoJSON.MultiLineString.is(multiLineString)