class @PhoneNumber.Carrier extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'PhoneNumber.Carrier'
  # EJSON serializable fields
  fields: ->
    type: String
    name: String
    mobile:
      countryCode: String  # https://www.itu.int/itudoc/itu-t/ob-lists/icc/e212_685.pdf
      networkCode: String

  constructor: (data) ->
    super(data)
    unless PhoneNumber.Carrier.isValid(data.type)
      throw new Error(PhoneNumber.Carrier.ERRORS.invalidCarrierType)

    @type = data.type if data.type?
    @name = data.name if data.name?

    if data.mobile?
      @mobile = {}
      @mobile.countryCode = data.mobile.countryCode if data.mobile.countryCode?
      @mobile.networkCode = data.mobile.networkCode if data.mobile.networkCode?
    Object.freeze(@)

  toString: -> @name
  isMobile: -> if @type then (@type == 'mobile') else null
  isLandline: -> if @type then (@type == 'landline') else null

  @_types: ['landline', 'mobile']
  @isType: (type) -> type in @_types
  @addType: (type) ->
    if type in @_types
      throw new Error(@ERRORS.carrierTypeExists)
    @_types.push type
  @isValid: (type) -> @isType(type)

  @ERRORS:
    invalidCarrierType: 'Invalid phone carrier type'
    carrierTypeExists: 'Phone number type already exists'