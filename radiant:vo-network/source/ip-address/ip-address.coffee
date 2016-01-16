class @IPAddress extends Space.domain.ValueObject
  # EJSON serializable fields
  fields: ->
    address : String
    version : Number

  toString: -> @address
  isVersion4: -> @version == 4
  isVersion6: -> @version == 6

  @_patterns:
    ipv4: RegExp.patterns.ipv4
    ipv6: RegExp.patterns.ipv6
  @classifyVersion: (address) ->
    version = null
    if @_patterns.ipv4.test(address)
      version = 4
    else if @_patterns.ipv6.test(address)
      version = 6
    return version
  @isValidIPv4: (address) -> @_patterns.ipv4.test(address)
  @isValidIPv6: (address) -> @_patterns.ipv6.test(address)