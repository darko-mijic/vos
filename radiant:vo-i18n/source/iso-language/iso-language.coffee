# https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
#
# With additional fillups of:
# https://en.wikipedia.org/wiki/List_of_ISO_639-2_codes
class @ISOLanguage extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'ISOLanguage'
  # EJSON serializable fields
  fields: ->
    code: String

  @ISO_LANGUAGE_CODES = [
    'fa', 'en', 'hi', 'ur', 'ps', 'tk', 'sq', 'el', 'hy', 'it', 'de', 'fr',
    'gn', 'to', 'hr', 'hu', 'sl', 'es', 'az', 'bs', 'bg', 'rn', 'pt', 'qu',
    'ay', 'nl', 'dz', 'iu', 'ln', 'kg', 'rm', 'ug', 'za', 'zh', 'cs', 'sk',
    'ar', 'aa', 'fo', 'et', 'gl', 'eu', 'oc', 'am', 'fj', 'co', 'gd', 'ka',
    'ee', 'tw', 'kl', 'wo', 'ff', 'sr', 'ht', 'id', 'jv', 'gv', 'bn', 'te',
    'mr', 'ta', 'gu', 'kn', 'ml', 'pa', 'as', 'bh', 'ks', 'ne', 'sd', 'sa',
    'ku', 'is', 'da', 'sv', 'no', 'sc', 'ja', 'ky', 'uz', 'km', 'kk', 'lo',
    'si', 'st', 'zu', 'xh', 'lt', 'pl', 'lb', 'lv', 'ro', 'tr', 'mg', 'mh',
    'bm', 'my', 'mn', 'tl', 'mt', 'dv', 'ny', 'th', 'af', 'hz', 'ha', 'kr',
    'yo', 'nb', 'nn', 'se', 'fi', 'na', 'ty', 'ho', 'tt', 'kv', 'ce', 'cv',
    'ba', 'rw', 'sw', 'sh', 'tg', 'av', 'uk', 'la', 'vi', 'bi', 'ts', 'ss',
    've', 'nr', 'sn', 'nd', 'cu', 'ca', 'om', 'ab', 'br', 'be', 'ca', 'eo',
    'fy', 'he', 'ia', 'ie', 'ik', 'ga', 'jw', 'ko', 'mk', 'ms', 'mi', 'mo',
    'or', 'ru', 'sm', 'sg', 'tn', 'so', 'su', 'bo', 'ti', 'vo', 'cy', 'yi',
    'zu'
  ]

  constructor: (data) ->
    code = if data and data.code then data.code else data

    unless ISOLanguage.isValid(code)
      throw new Error(ISOLanguage.ERRORS.notFound)

    @code = code
    Object.freeze(@)

  toString: -> @code
  @codes: -> @ISO_LANGUAGE_CODES
  @isValid: (code) -> @ISO_LANGUAGE_CODES.indexOf(code) > -1

  @ERRORS:
    notFound: 'Language with ISO code not found'

