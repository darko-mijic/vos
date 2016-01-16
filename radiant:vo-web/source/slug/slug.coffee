class @Slug extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Slug'
  # EJSON serializable fields
  fields: ->
    value: String

  constructor: (data, options) ->
    value = if data and data.value then data.value else data

    unless Slug.isValid(value)
      throw new Error(Slug.ERRORS.invalidSlug)

    @value = value
    Object.freeze(@)

  toString: -> @value

  @optionsFields:
    transliterations: Match.Optional(Object)
    replacement: Match.Optional(String)
    maxLength: Match.Optional(Number)
    lowercasify: Match.Optional(Boolean)

  @slugify: (string, options={}) ->
    check(options, @optionsFields)
    return false unless lodash.isString(string)

    # Defaults
    transliterations = options.transliterations or @transliterations()
    if options.replacement or options.replacement == ''
      replacement = options.replacement
    else
      replacement = @defaultReplacement()
    maxLength = options.maxLength or @maxLength()
    if options.lowercasify? and lodash.isBoolean(options.lowercasify)
      lowercasify = options.lowercasify
    else
      lowercasify = true

    slug = ''
    lodash.each string, (char) ->
      if lodash.has(transliterations, char)
        char = transliterations[char]
      else
        char = lodash.deburr(char)
      char = char.replace(/[^\w\s$\*\_\+~\.\(\)\-]/g, '')
      slug = slug + char

    slug = slug
      .replace(/'/g, '')               # Remove all apostrophes
      .replace(/\./g, replacement)               # Remove all dots
      .replace(/[-\s]+/g, replacement) # Convert spaces
      .replace('#{replacement}$', '')  # Remove trailing separator
      .replace(/[^0-9a-zA-Z-]/g, '-')  # Replace anything that is not 0-9, a-z, or - with -
      .replace(/\-\-+/g, '-')          # Replace multiple - with single -
      .replace(/^-+/, '')              # Trim - from start of text
      .replace(/-+$/, '')              # Trim - from end of text

    slug = slug.toLowerCase() if lowercasify

    if maxLength > 0 && slug.length > maxLength
      slug = lodash.trunc(slug, {length: maxLength, omission: ''})

    return new Slug(slug)

  @isValid: (slug) -> lodash.isString(slug)

  @_defaultReplacement: '-'
  @defaultReplacement: ->  @_defaultReplacement

  @_transliterations
  @transliterations: -> @_transliterations
  @setTransliterations: (mappings) ->
    @_transliterations = mappings
  @hasTransliteration: (char) ->
    @_transliterations[char]?
  @addTransliteration: (charFrom, charTo) ->
    @_transliterations[charFrom] = charTo

  @_maxLength: null
  @maxLength: -> @_maxLength
  @isValidLength: (value) ->
    lodash.isNumber(value) and value >= 1 and value < Number.MAX_VALUE
  @setMaxLength: (value) ->
    unless @isValidLength(value) then throw new Error(@ERRORS.invalidLength)
    @_maxLength = value

  @ERRORS:
    invalidSlug: 'Match error: Expected string'
    invalidLength: 'Length must be a natural number equal or above 1'
