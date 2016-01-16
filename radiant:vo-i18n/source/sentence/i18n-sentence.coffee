class @I18nSentence extends I18nValueObject
  # Register as EJSON type
  @type 'I18nSentence'
  # EJSON serializable fields
  fields: ->
    i18n: [Sentence]

  constructor: (data) ->
    data = {i18n: [data]} if data instanceof Sentence
    data = {i18n: data} if lodash.isArray(data)
    super(data)

    unless I18nSentence.isValid(data)
      throw new Error(I18nSentence.ERRORS.multiple)

    Object.freeze(@)

  fill: (i18nNew) -> I18nSentence.fill(@, i18nNew)
  @_create: (data) -> new I18nSentence(data)


  @ERRORS:
    multiple: 'Must contain only one internationalization(Sentence) per language'
    invalid: 'Must be instance of I18nSentence'
