class @NIN extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'NIN'
  # EJSON serializable fields
  fields: ->
    nin : String
    country: ISOCountry

  @validators: new Radiant.domain.ValueObjectValidators()

  constructor: (data) ->
    super(data)

    NIN.validate(data)
    Object.freeze(@)

  toString: -> @nin
  @validate: (data) ->
    unless @isValid(data.nin, data.country.toString())
      throw new Error(@ERRORS.invalidNIN)
    return true

  @isValid: (nin, isoCountryCode) ->
    validator = @validators.get(isoCountryCode)

    if validator then validator(nin) else false

  @ERRORS:
    invalidNIN: 'Invalid NIN'