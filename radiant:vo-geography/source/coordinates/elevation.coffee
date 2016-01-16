class @Elevation extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Elevation'
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