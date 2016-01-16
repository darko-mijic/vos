class @Distance.BetweenPoints extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Distance.BetweenPoints'
  # EJSON serializable fields
  fields: ->
    from: GeoJSON.Point
    to: GeoJSON.Point
    length: Length

  constructor: (data) ->
    data.unit = new LengthUnit(Length.defaultUnit) unless data.unit?
    if not data.length and (data.from and data.to)
      data.length = Distance.BetweenPoints.calculate(
        data.from,
        data.to,
        data.unit
      )

    @from   = data.from
    @to     = data.to
    @length = data.length
    Object.freeze(@)

  convert: (unit, round) ->
    unless Distance.BetweenPoints.isLengthUnit(unit)
      throw new Error(Distance.BetweenPoints.ERRORS.invalidUnit)

    convertedLength = @length.convert(unit, round or null)
    return new Distance.BetweenPoints({
      from: @from
      to: @to
      length: convertedLength
    })


  @_geolib: geolib
  @calculate: (from, to, unit) ->
    for type, point of {from: from, to: to}
      unless @isValidGeoJSONPoint(point)
        throw new Error(@ERRORS.invalidPoint(type))

    unless @isLengthUnit(unit)
      throw new Error(Distance.BetweenPoints.ERRORS.invalidUnit)

    length = new Length({
      value: @_geolib.getDistance(
        {latitude: from.latitude(), longitude: from.longitude()}
        {latitude: to.latitude(), longitude: to.longitude()}
      )
      unit: new LengthUnit(LengthUnit.UNITS.meter)
    })

    unless length.isIn(unit)
      length = length.convert(unit)
    return length

  @isValidGeoJSONPoint: (point) -> GeoJSON.Point.is(point)
  @isLengthUnit: (unit) -> LengthUnit.is(unit)

  @ERRORS:
    invalidPoint: (type) -> "Invalid #{type} GeoJSON.Point"
    invalidUnit: 'Invalid unit'