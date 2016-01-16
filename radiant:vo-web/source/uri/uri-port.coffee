class @URI.Port extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'URI.Port'
  # EJSON serializable fields
  fields: ->
    port: Number

  @range:
    min: 0
    max: 65535

  constructor: (data) ->
    port = if data and data.port then data.port else data
    port = Number(port) unless lodash.isNumber(port)

    unless URI.Port.isValid(port)
      throw new Error(URI.Port.ERRORS.portNotInRage)

    @port = port
    Object.freeze(@)

  toString: -> @port
  @isValid: (port) -> @isInRange(port)
  @isInRange: (port) -> (port > @range.min and port < @range.max)

  @ERRORS:
    portNotInRage: "Port not in number range"