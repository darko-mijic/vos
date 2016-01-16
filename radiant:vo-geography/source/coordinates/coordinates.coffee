# WGS84
# https://en.wikipedia.org/wiki/World_Geodetic_System
# http://geojson.org/geojson-spec.html#coordinate-reference-system-objects
#
# Since unclear on elevation for GeoJSON, assume this is right:
# http://www.macwright.org/2015/03/23/geojson-second-bite.html#position
# http://gis.stackexchange.com/questions/63489/what-are-the-default-UNITS-of-elevation-altitude-z-in-geojson
class @Coordinates extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Coordinates'
  # EJSON serializable fields
  fields: ->
    longitude : Longitude
    latitude  : Latitude
    elevation : Match.Optional(Elevation)

  constructor: (data) ->
    if Coordinates.areValidArrayCoordinates(data)
      Coordinates.validateArrayCoordinates(data)

      obj = {}
      obj.longitude = data[0]
      obj.latitude = data[1]
      obj.elevation = data[2] if data[2]?
      data = obj

    data.longitude = new Longitude(parseFloat(data.longitude)) unless Coordinates.isLongitude(data.longitude)
    data.latitude  = new Latitude(parseFloat(data.latitude)) unless Coordinates.isLatitude(data.latitude)
    if data.elevation and not Coordinates.isElevation(data.elevation)
      data.elevation = new Elevation(parseFloat(data.elevation))

    super(data)
    Object.freeze(@)

  toArray: ->
    array = [@longitude.value, @latitude.value]
    array.push @elevation.value if @elevation?
    return array
  toObject: ->
    data = {}
    data.longitude = @longitude.value
    data.latitude = @latitude.value
    data.elevation = @elevation.value if @elevation
    return data

  @areValidArrayCoordinates: (coordinates) ->
    lodash.isArray(coordinates) and !(coordinates.length > 3 or coordinates.length < 2)

  @_specification:
    longitude: 0
    latitude: 1
    elevation: 2
  @validateArrayCoordinates: (coordinates) ->
    if @isNumberBasedArrayCoordinates(coordinates) then return true

    for element, position of @_specification
      unless @["is#{element.capitalize()}"](coordinates[position])
        throw new Error(@ERRORS["invalid#{element.capitalize()}Position"](position))
    return true

  @isNumberBasedArrayCoordinates: (coordinates) ->
    !lodash.contains(lodash.map(coordinates, (item) -> lodash.isNumber(item)), false)
  @isLongitude: (longitude) -> Longitude.is(longitude)
  @isLatitude: (latitude) -> Latitude.is(latitude)
  @isElevation: (elevation) -> Elevation.is(elevation)

  @ERRORS:
    invalidLongitudePosition: (position) ->
      "Longitude should be specified at #{position} index of array"
    invalidLatitudePosition: (position) ->
      "Latitude should be specified at #{position} index of array"
    invalidElevationPosition: (position) ->
      "Elevation should be specified at #{position} index of array"