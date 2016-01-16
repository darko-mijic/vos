class @LengthUnit extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'LengthUnit'
  # EJSON serializable fields
  fields: ->
    unit: String

  @UNITS:
    meter       : 'm'
    kilometer   : 'km'
    centimeter  : 'cm'
    millimeter  : 'mm'
    mile        : 'mi'
    seamile     : 'sm'
    foot        : 'ft'
    inch        : 'in'
    yard        : 'yd'

  constructor: (data) ->
    unit = if data and data.unit then data.unit else data
    unless LengthUnit.isValid(unit)
      throw new Error(LengthUnit.ERRORS.invalidEmail)

    # Assign as short
    if LengthUnit.isLongUnit(unit)
      @unit = LengthUnit.convertToShort(unit)
    else
      @unit = unit
    Object.freeze(@)

  toString: -> @long()
  short: -> @unit
  long: -> LengthUnit.convertToLong(@unit)

  @isValid: (unit) ->
    (lodash.isString(unit) and (@isLongUnit(unit) or @isShortUnit(unit)))

  @isLongUnit: (unit) -> unit in lodash.keys(@UNITS)
  @isShortUnit: (unit) -> unit in lodash.values(@UNITS)
  @convertToShort: (longUnit) ->
    unless @isLongUnit(longUnit)
      throw new Error(@ERRORS.notFoundLongNotationUnit)
    @UNITS[longUnit]
  @convertToLong: (shortUnit) ->
    unless @isShortUnit(shortUnit)
      throw new Error(@ERRORS.notFoundShortNotationUnit)
    lodash.invert(@shortUnit)[shortUnit]

  @ERRORS:
    invalidUnit: 'Invalid length unit'
    notFoundShortNotationUnit: 'Short notation of length unit not found'
    notFoundLongNotationUnit: 'Long notation of length unit not found'