class @Translation extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Translation'
  # EJSON serializable fields
  fields: ->
    from: Sentence
    to: Sentence
    score = Match.Optional(Match.ObjectIncluding({
      isReliable: Match.Optional(Boolean)
      confidence: Match.Optional(Number)
    }))

  constructor: (data) ->
    super(data)
    Object.freeze(@)

  isReliable: ->
    if @score.isReliable? then return @score.isReliable
    if @score.confidence > Translation.threshold() then true else false
  toString: -> @to.value

  @_threshold: 0.8
  @setThreshold: (value) -> @_threshold = value
  @threshold: -> @_threshold

