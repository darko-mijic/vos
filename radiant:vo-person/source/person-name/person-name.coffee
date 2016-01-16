class @PersonName extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'PersonName'
  # EJSON serializable fields
  fields: ->
    firstName: String
    middleName: Match.Optional(String)
    lastLast: String

  constructor: (data) ->
    super(data)
    Object.freeze(@)

  toString: -> @format()
  format: ->
    data = {}
    data.firstName = @firstName
    data.middleName = @middleName if @middleName?
    data.lastName = @lastName

    return PersonName.format(data)

  @format: (data) ->
    format = ['firstName', 'lastName']
    parts = []
    for key, value of data
      if key in format
        if lodash.isArray(value)
          parts.push value.join(' ')
        else
          parts.push value

    return parts.join(' ')
