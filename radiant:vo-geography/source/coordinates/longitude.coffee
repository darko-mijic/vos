class @Longitude extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Longitude'
  # EJSON serializable fields
  fields: ->
    value: Number

  constructor: (data) ->
    if lodash.isNumber(data)
      data = {value: data}
    else
      data = {value: Number(data)}

    super(data)
    Object.freeze(@)
