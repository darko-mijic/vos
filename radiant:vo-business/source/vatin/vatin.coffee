class @VATIN extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'VATIN'
  # EJSON serializable fields
  fields: ->
    value: String
    country: ISOCountry

  @validators: new Radiant.domain.ValueObjectValidators()

  constructor: (data) ->
    super(data)

    VATIN.validate(data)
    Object.freeze(@)

  toString: -> @value
  @validate: (data) ->
    unless @isValid(data.value, data.country.toString())
      throw new Error(@ERRORS.invalidVATINSpecificCountry)
    return true

  @isValid: (value, isoCountryCode) ->
    return false unless ISOCountry.isEuropean(isoCountryCode)
    validator = @validators.get(isoCountryCode)

    if validator then validator(value) else false

  @ERRORS:
    invalidVATINSpecificCountry: 'Invalid VATIN for specific country'