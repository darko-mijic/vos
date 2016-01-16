class @EmailAddress extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'EmailAddress'
  # EJSON serializable fields
  fields: ->
    address: String

  constructor: (data) ->
    address = if data and data.address then data.address else data

    unless EmailAddress.isValid(address)
      throw new Error(EmailAddress.ERRORS.invalidEmail)

    @address = address
    Object.freeze(@)

  toString: -> @address
  domain: -> @address.split('@')[1]

  @_pattern: RegExp.patterns.email
  @isValid: (address) ->
    (lodash.isString(address) and @_pattern.address.test(data.address))

  @ERRORS:
    invalidEmail: 'Email address must be a valid e-mail address'