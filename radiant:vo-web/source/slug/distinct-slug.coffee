class @DistinctSlug extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'DistinctSlug'
  # EJSON serializable fields
  fields: ->
    baseSlug : Slug
    slug     : Slug
    index    : Number
    isCustom : Boolean

  constructor: (data) ->
    data.index = 0 unless data.index?
    super(data)
    Object.freeze(@)
  toString: -> @slug.toString()
  hasIndex: -> @index > 0
  increment: -> DistinctSlug.increment(@)

  @increment: (distinctSlug) ->
    @_validateDistinctSlug(distinctSlug)
    return new DistinctSlug {
      baseSlug: distinctSlug.baseSlug
      slug: distinctSlug.slug
      index: distinctSlug.index + 1
      isCustom: distinctSlug.isCustom
    }

  @_validateDistinctSlug: (distinctSlug) ->
    check(distinctSlug, DistinctSlug)