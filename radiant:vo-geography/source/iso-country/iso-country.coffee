# https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
class @ISOCountry extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'ISOCountry'
  # EJSON serializable fields
  fields: ->
    code: String

  @ISO_COUNTRY_CODES: [
    'AF', 'AX', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW',
    'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT',
    'BO', 'BQ', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM',
    'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD',
    'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC',
    'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF',
    'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GU', 'GT',
    'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID',
    'IR', 'IQ', 'IE', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI',
    'KP', 'KR', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU',
    'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT',
    'MX', 'FM', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP',
    'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'MP', 'NO', 'OM', 'PK', 'PW',
    'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'PR', 'QA', 'RE', 'RO',
    'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA',
    'SN', 'RS', 'SC', 'SL', 'SG', 'SX', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'SS',
    'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH',
    'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE',
    'GB', 'US', 'UM', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'VI', 'WF', 'EH', 'YE',
    'ZM', 'ZW',
  ]
  @EUROPEAN_ISO_COUNTRY_CODES: [
    'AL', 'AD', 'AT', 'BY', 'BE', 'BA', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE',
    'FO', 'FI', 'FR', 'DE', 'GI', 'GR', 'HU', 'IS', 'IE', 'IT', 'LV', 'LI',
    'LT', 'LU', 'MK', 'MT', 'MD', 'MC', 'NL', 'NO', 'PL', 'PT', 'RO', 'RU',
    'SM', 'RS', 'SK', 'SI', 'ES', 'SE', 'CH', 'UA', 'GB', 'VA', 'RS', 'IM',
    'RS', 'ME',
  ]
  @COUNTRY_USED_LANGAUGES: {}

  constructor: (data) ->
    code = if data and data.code then data.code else data
    code = code.toUpperCase() if lodash.isString(code)

    unless ISOCountry.isValid(code)
      throw new Error(ISOCountry.ERRORS.invalidCountryCode)

    @code = code
    Object.freeze(@)

  toString: -> @code
  isEuropean: -> @constructor.isEuropean(@code)
  language: ->
    unless @hasLanguage()
      throw new Error(ISOCountry.ERRORS.languageNotSpecified)
    new ISOLanguage(ISOCountry.COUNTRY_USED_LANGAUGES[@code][0])
  languages: ->
    isoLanguages = []
    langCodes = ISOCountry.COUNTRY_USED_LANGAUGES[@code]
    for langCode in langCodes
      isoLanguages.push(new ISOLanguage(langCode))
    return languages
  hasLanguage: ->
    ISOCountry.COUNTRY_USED_LANGAUGES[@code]?

  @codes: -> @ISO_COUNTRY_CODES
  @europeanCodes: -> @EUROPEAN_ISO_COUNTRY_CODES
  @isValid: (code) -> (lodash.isString(code) and code in @ISO_COUNTRY_CODES)
  @isEuropean: (isoCountry) ->
    isoCountry.toString() in @EUROPEAN_ISO_COUNTRY_CODES



  @ERRORS:
    invalidCountryCode: 'Invalid country code'
    languageNotSpecified: 'Official language for country not specified'