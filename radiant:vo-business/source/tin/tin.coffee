class @TIN extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'TIN'
  # EJSON serializable fields
  fields: ->
    value: String
    country: ISOCountry

  @validators: new Radiant.domain.ValueObjectValidators()

  constructor: (data) ->
    super(data)

    TIN.validate(data)
    Object.freeze(@)

  toString: -> @value
  @validate: (data) ->
    unless @isValid(data.value, data.country.toString())
      throw new Error(@ERRORS.invalidTINSpecificCountry)
    return true

  @isValid: (value, isoCountryCode) ->
    validator = @validators.get(isoCountryCode)

    if validator then validator(value) else false

  @ERRORS:
    invalidTINSpecificCountry: 'Invalid TIN for specific country'