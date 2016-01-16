class @DetectedLanguage extends Sentence
  # Register as EJSON type
  @type 'DetectedLanguage'
  # EJSON serializable fields
  fields: ->
    language: ISOLanguage
    value: String
    score = Match.Optional(Match.ObjectIncluding({
      isReliable: Match.Optional(Boolean)
      confidence: Match.Optional(Number)
    }))

  constructor: (data) ->
    super(data)

  isReliable: ->
    if @score.isReliable? then return @score.isReliable
    if @score.confidence > Translation.threshold() then true else false
  toString: -> @value

  @_threshold: 0.8
  @setThreshold: (value) -> @_threshold = value
  @threshold: -> @_threshold
