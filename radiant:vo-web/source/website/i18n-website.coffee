class @I18nWebsite extends I18nValueObject
  # Register as EJSON type
  @type 'I18nWebsite'
  # EJSON serializable fields
  fields: ->
    i18n: [Website]

  constructor: (data) ->
    data = {i18n: [data]} if data instanceof Website
    data = {i18n: data} if lodash.isArray(data)
    super(data)

    unless I18nWebsite.isValid(data)
      throw new Error(I18nWebsite.ERRORS.multiple)

    Object.freeze(@)

  fill: (i18nNew) -> I18nWebsite.fill(@, i18nNew)
  @_create: (data) -> new I18nWebsite(data)

  @ERRORS:
    multiple: 'Must contain only one website(URI) per language'
