class @IPv4Address extends IPAddress
  # Register as EJSON type
  @type 'IPv4Address'

  constructor: (data) ->
    address = if data and data.address then data.address else data

    unless IPv4Address.isValid(address)
        throw new Error(IPv4Address.ERRORS.invalidIPv4)

    @address = address
    @version = 4
    Object.freeze(@)

  @isValid: (address) ->
    (address? and lodash.isString(address) and @isValidIPv4(address))

  @ERRORS:
    invalidIPv4: 'Invalid of IPv4 address'