class @ZipCode extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'ZipCode'
  # EJSON serializable fields
  fields: ->
    value : String
    country: ISOCountry

  @validators: new Radiant.domain.ValueObjectValidators()

  constructor: (data) ->
    super(data)

    ZipCode.validate(data)
    Object.freeze(@)

  toString: -> @value

  @validate: (data) ->
    unless @isValid(data.value, data.country.toString())
      throw new Error(@ERRORS.invalidZipCodeSpecificCountry)
    return true

  @isValid: (value, isoCountryCode) ->
    validator = @validators.get(isoCountryCode)

    if validator then validator(value) else false

  @ERRORS:
    invalidZipCodeSpecificCountry: 'Invalid ZipCode for specific country'