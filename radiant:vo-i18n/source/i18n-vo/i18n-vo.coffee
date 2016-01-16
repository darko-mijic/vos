class @I18nValueObject extends Space.domain.ValueObject

  fill: (i18nNew) -> throw new NotImpelementedError()
  @_create: (data) -> throw new NotImpelementedError()

  isIntenationalized: -> @i18n.length > 1
  forLanguage: (isoLangauge) ->
    @_validateISOLanguage(isoLangauge)
    for translation in @i18n
      return translation if isoLangauge.equals(translation.language)
    return null
  hasLanguage: (isoLangauge) ->
    @_validateISOLanguage(isoLangauge)
    for translation in @i18n
      return true if isoLangauge.equals(translation.language)
    return null

  _validateISOLanguage: (isoLangauge) -> check(isoLangauge, ISOLanguage)

  @fill: (i18nOld, i18nNew) ->
    for i18nObj in [i18nOld, i18nNew]
      unless @is(i18nObj)
        throw new Error('Match error: Expected instance of I18nValueObject')

    i18n = {}
    i18n[sentence.language.toString()] = sentence for sentence in i18nOld.i18n
    # Replace with new ones
    i18n[sentence.language.toString()] = sentence for sentence in i18nNew.i18n
    return @_create(lodash.values(i18n))

  @isValid: (data) ->
    languages = []
    languages.push(sentence.language.toString()) for sentence in data.i18n

    # Validate, that only one sentence is provided per langauge
    return languages.length == lodash.uniq(languages).length
