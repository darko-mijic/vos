class @DigitToken extends Token
  # Register as EJSON type
  @type 'DigitToken'
  # EJSON serializable fields
  fields: ->
    value: Number

  constructor: (data) ->
    value = if data and data.value then data.value else data
    value = DigitToken.generate() unless value?

    unless DigitToken.isValid(value, requiredLength)
      throw new Error(DigitToken.ERRORS.invalidToken)

    @value = value

    Object.freeze(@)

  @isValid: (token, requiredLength=null) ->
    lodash.isNumber(token) and String(token).length == requiredLength and
    token < Number.MAX_VALUE
  @generate: (requiredLength) ->
    requiredLength = @requiredLength() unless requiredLength?
    Math.floor(Math.random() * Math.pow(10, requiredLength - 1)) +
    Math.pow(10, requiredLength - 1)

DigitToken.ERRORS.invalidToken = 'Token must be a number with required length'
DigitToken.setLength(8)