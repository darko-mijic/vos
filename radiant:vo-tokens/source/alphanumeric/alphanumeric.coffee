class @AlphanumericToken extends Token
  # Register as EJSON type
  @type 'AlphanumericToken'
  # EJSON serializable fields
  fields: ->
    value: String

  constructor: (data) ->
    value = if data and data.value then data.value else data
    value = AlphanumericToken.generate() unless value?

    unless AlphanumericToken.isValid(value)
      throw new Error(AlphanumericToken.ERRORS.invalidToken)

    @value = value

    Object.freeze(@)

  @_pattern: /^[a-zA-Z0-9_-]+$/
  @isValid: (token, requiredLength=null) ->
    requiredLength = @requiredLength() unless requiredLength?

    return (lodash.isString(token) and token.length == requiredLength and
      @_pattern.test(token))


  @_lib: Random
  @generate: (requiredLength=null) ->
    requiredLength = @requiredLength() unless requiredLength?
    @_lib.secret(requiredLength)

AlphanumericToken.ERRORS.invalidToken = 'Token must be a alphanumeric string with required length'
AlphanumericToken.setLength(43)
