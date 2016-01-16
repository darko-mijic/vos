class @GeoJSON.Point extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'GeoJSON.Point'
  # EJSON serializable fields
  fields: ->
    type: String
    coordinates: [Number] # Specs

  constructor: (data) ->
    coordinates = if data and data.coordinates then data.coordinates else data
    coordinates = new Coordinates(coordinates) unless GeoJSON.isCoordinates(coordinates)

    @type = 'Point'
    @coordinates = coordinates.toArray()
    Object.freeze(@)

  longitude: -> @coordinates[0]
  latitude:  -> @coordinates[1]
  elevation: -> @coordinates[2] or null

  isInRadius: (centerGeoJSONPoint, radius) ->
    GeoJSON.Point.isInRadius(@, centerGeoJSONPoint, radius)

  @_geolib: geolib
  @defaultRadiusInMeters: new Radius({
    value: 1000,
    unit: new LengthUnit(LengthUnit.UNITS.meter)
  })
  @isInRadius: (pointToSearch, centerGeoJSONPoint, radius) ->
    radius = @defaultRadiusInMeters unless radius?

    unless @isRadius(radius)
      throw new Error(@ERRORS.invalidRadius)
    unless radius.isIn(LengthUnit.UNITS.meter)
      radius = radius.convert(new LengthUnit(LengthUnit.UNITS.meter))
    unless @is(centerGeoJSONPoint) or @is(pointToSearch)
      throw new Error(@ERRORS.invalidGeoJSONPoint)

    return @_geolib.isPointInCircle(
      new Coordinates(pointToSearch.coordinates).toObject(),
      new Coordinates(centerGeoJSONPoint.coordinates).toObject(),
      radius.value
    )

  @ERRORS:
    invalidGeoJSONPoint: 'GeoJSON.Point must be instance of GeoJSON.Point'
    invalidRadius: 'Radius must be instance of Radius'
  @isRadius: (radius) -> radius instanceof Radius

GeoJSON.addGeometery('Point', GeoJSON.Point)
GeoJSON.isPoint = (point) -> GeoJSON.Point.is(point)
