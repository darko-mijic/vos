class @Street extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Street'
  # EJSON serializable fields
  fields: ->
    name: String
    number: Match.Optional(String) # 1a 2b thats why String
    elements: Match.Optional([String]) # Building, floor and unit

  constructor: (data) ->
    data.number = String(data.number) if data.number? # '1abcd'
    super(data)
    Object.freeze(@)

  format: ->
    data = {}
    data.name = @name
    data.number = @number if @number?
    data.elements = @elements if @elements?

    return @constructor.format(data)

  toString: -> @format()
  isFilled: -> (@name? and @number?)
  @format: (data) ->
    format = ['name', 'number', 'elements']
    parts = []
    for key, value of data
      if key in format
        if lodash.isArray(value)
          parts.push value.join(' ')
        else
          parts.push value

    return parts.join(' ')