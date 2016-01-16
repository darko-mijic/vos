class @Sentence extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Sentence'
  # EJSON serializable fields
  fields: ->
    language: ISOLanguage
    value: String

  constructor: (data) ->
    super(data)
    Object.freeze(@)

  toString: -> @value