class @Website extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Website'
  # EJSON serializable fields
  fields: ->
    uri: URI
    language: ISOLanguage

  constructor: (data) ->
    super(data)
    Object.freeze(@)
  toString: -> @uri