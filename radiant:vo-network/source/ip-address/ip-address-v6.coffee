class @IPv6Address extends IPAddress
  # Register as EJSON type
  @type 'IPv6Address'

  constructor: (data) ->
    address = if data and data.address then data.address else data

    unless IPv6Address.isValid(address)
        throw new Error(IPv6Address.ERRORS.invalidIPv6)

    @address = address
    @version = 6
    Object.freeze(@)

  @isValid: (address) ->
    (address? and lodash.isString(address) and @isValidIPv6(address))

  @ERRORS:
    invalidIPv6: 'Invalid of IPv6 address'