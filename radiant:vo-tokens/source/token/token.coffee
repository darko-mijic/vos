class @Token extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Token'
  # EJSON serializable fields
  fields: ->
    value: Number

  length: -> String(@token).length
  toString: -> @value

  @isValid: (token) -> throw new NotImplementedError()
  @generate: -> throw new NotImplementedError()

  @_length: 8
  @requiredLength: -> @_length
  @isValidLength: (value) ->
    lodash.isNumber(value) and value >= 1 and value < Number.MAX_VALUE
  @setLength: (value) ->
    unless @isValidLength(value) then throw new Error(@ERRORS.invalidLength)
    @_length = value

  @ERRORS:
    invalidLength: 'Length must be a natural number equal or above 1'
