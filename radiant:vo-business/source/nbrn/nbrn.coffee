# National Business Registry Number
class @NBRN extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'NBRN'
  # EJSON serializable fields
  fields: ->
    value : String
    country: ISOCountry

  @validators: new Radiant.domain.ValueObjectValidators()

  constructor: (data) ->
    super(data)

    NBRN.validate(data)
    Object.freeze(@)

  toString: -> @value
  @validate: (data) ->
    unless @isValid(data.value, data.country.toString())
      throw new Error(@ERRORS.invalidNBRNSpecificCountry)
    return true

  @isValid: (value, isoCountryCode) ->
    validator = @validators.get(isoCountryCode)

    if validator then validator(value) else false

  @ERRORS:
    invalidNBRNSpecificCountry: 'Invalid NBRN for specific country'