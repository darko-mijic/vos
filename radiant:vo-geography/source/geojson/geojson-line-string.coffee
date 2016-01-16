class @GeoJSON.LineString extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'GeoJSON.LineString'
  # EJSON serializable fields
  fields: ->
    type: String
    coordinates: [[Number]]

  constructor: (data) ->
    data = {coordinates: @_convertCoordinatesToArrayFromData(data)}
    data.type = 'LineString'

    super(data)
    Object.freeze(@)

  _convertCoordinatesToArrayFromData: (data) ->
    coordinates = if data and data.coordinates then data.coordinates else data
    if not coordinates or not lodash.isArray(coordinates) or lodash.isEmpty(coordinates)
      throw new Error(GeoJSON.LineString.ERRORS.invalidCoordinates)

    convertedArray = []
    for pointCords in coordinates
      unless Coordinates.is(pointCords)
        pointCords = new Coordinates(pointCords)

      convertedArray.push pointCords.toArray()
    return convertedArray
  @ERRORS:
    invalidCoordinates: 'Invalid coordinates data for GeoJSON.LineString'

GeoJSON.addGeometery('LineString', GeoJSON.LineString)
GeoJSON.isLineString = (lineString) -> GeoJSON.LineString.is(lineString)