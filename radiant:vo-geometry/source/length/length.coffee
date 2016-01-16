class @Length extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Length'
  # EJSON serializable fields
  fields: ->
    unit: LengthUnit
    value: Number

  constructor: (data) ->
    super(data)

    unless Length.isValid(data.value)
      throw new Error(Length.ERRORS.notNatural)

    Object.freeze(@)

  toString: -> "#{@value} #{@unit.toString()}"
  toNumber: -> @value
  toObject: ->
    obj = {}
    obj.unit = @unit.toString()
    obj.value = @value
    return obj
  isIn: (unit) -> (unit == @unit.short() or unit == @unit.long())
  convert: (unit, round) -> Length.convert(@, unit, round or null)

  @isValid: (value) -> value > -1
  @round: 2
  @defaultUnit: LengthUnit.UNITS.meter
  @_geolib: geolib
  @convert: (length, unit, round) ->
    unless @is(length) then throw new Error(@ERRORS.invalid)

    data = {}
    data.value = @_calculateConversion(length, unit, round or null)
    data.unit = unit
    return new Length(data)

  @_calculateConversion: (length, unit, round) ->
    unless @isLengthUnit(unit) then throw new Error(Length.ERRORS.invalidLengthUnit)
    unless round then round = @round

    unless length.isIn(LengthUnit.UNITS.meter)
      lengthInMeters = length.convert(@UNITS.meter)
    else
      lengthInMeters = length

    return @_geolib.convertUnit(unit.short(), lengthInMeters.toNumber(), round)
  @isLengthUnit: (unit) -> LengthUnit.is(unit)

  @ERRORS:
    invalidLength: 'Length must be instance of Length'
    notNatural: 'Length value must be natural number'
    invalidLengthUnit: 'Length unit must be instance of LengthUnit'
