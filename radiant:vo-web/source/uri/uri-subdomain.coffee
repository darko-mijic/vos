class URI.Subdomain extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'URI.Subdomain'
  # EJSON serializable fields
  fields: ->
    subdomain: String

  constructor: (data, options) ->
    subdomain = if data and data.subdomain then data.subdomain else data

    unless URI.Subdomain.isValid(subdomain)
      throw new Error(URI.Subdomain.ERRORS.invalidSubdomain)

    @subdomain = subdomain
    Object.freeze(@)

  toString: -> @subdomain

  @_pattern: /^([^.\s-])([^.\s]+)[^.\s-]$/
  @isValid: (subdomain) -> lodash.isString(subdomain) and @_pattern.test(subdomain)
  @_slugOptions:
    replacement: '-'
    lowercasify: true
  @normalize: (subdomain) ->
    slugOptions = @_slugOptions
    slugOptions.maxLength = @maxLength unless @_slugOptions.maxLength?

    slug = Slug.slugify(subdomain, slugOptions)
    new URI.Subdomain(slug.toString())

  @_maxLength: null
  @maxLength: -> @_maxLength
  @isValidLength: (value) ->
    lodash.isNumber(value) and value >= 1 and value < Number.MAX_VALUE
  @setMaxLength: (value) ->
    unless @isValidLength(value) then throw new Error(@ERRORS.invalidLength)
    @_maxLength = value

  @ERRORS:
    invalidSubdomain: 'Match error: Expected string, dots are not allowed and
      dash symbol is not allowed at start or end of string'
    invalidLength: 'Length must be a natural number equal or above 1'