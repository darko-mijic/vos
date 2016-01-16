class @PhoneNumber.Type extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'PhoneNumber.Type'
  # EJSON serializable fields
  fields: ->
    type: String

  constructor: (data) ->
    type = if data and data.type then data.type else data
    type = type.toLowerCase() if lodash.isString(type)

    unless PhoneNumber.Type.isValid(type)
      throw new Error(PhoneNumber.Type.ERRORS.invalidType)

    @type = type if type?
    Object.freeze(@)

  toString: -> @tyep

  @_types: ['home', 'work', 'fax', 'mobile', 'other']
  @isType: (type) -> type in @_types
  @addType: (type) ->
    if type in @_types
      throw new Error(@ERRORS.phoneNumberTypeExists)
    @_types.push type
  @isValid: (type) -> lodash.isString(type) and @isType(type)

  @ERRORS:
    invalidType: 'Invalid phone number type'
    phoneNumberTypeExists: 'Phone number type already exists'