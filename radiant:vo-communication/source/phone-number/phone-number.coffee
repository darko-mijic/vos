class @PhoneNumber extends PhoneNumber
  # Register as EJSON type
  @type 'PhoneNumber'
  # EJSON serializable fields
  fields: ->
    number    : String
    formatted : Match.Optional(String)
    country   : Match.Optional(ISOCountry)
    carrier   : Match.Optional(PhoneNumber.Carrier)
    type      : Match.Optional(PhoneNumber.Type)

  constructor: (data) ->
    data = {number: data} if lodash.isString(data)
    data.number = PhoneNumber.normalize(data.number)

    super(data)
    unless PhoneNumber.isValid(data.number)
      throw new Error(PhoneNumber.ERRORS.invalidPhoneNumber)

    @number    = data.number
    @formatted = data.formatted if data.formatted?
    @country   = data.country if data.country?
    @carrier   = data.carrier if data.carrier?
    Object.freeze(@) # Make this Object immutable, without strict there is not TypeError

  toString: -> @formatted or @number
  isMobile: -> if @carrier then @carrier.isMobile() else null
  isLandline: -> if @carrier then @carrier.isLandline() else null

  @_patterns:
    number: RegExp.patterns.phoneNumber
  @isValid: (number) -> @_patterns.number.test(number)
  @normalize: (number) -> number.replace(/\s/g, '').replace(/-/g, '')

  @ERRORS:
    invalidPhoneNumber: 'Invalid phone number'