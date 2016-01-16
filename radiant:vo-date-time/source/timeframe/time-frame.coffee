class @TimeFrame extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'TimeFrame'
  # EJSON serializable fields
  fields: ->
    from: Date
    to: Date

  constructor: (data) ->
    super(data)
    Object.freeze(@)

  isBefore: (comparedDate) ->
    TimeFrame.isBefore(@, comparedDate)
  isAfter: (comparedDate) ->
    TimeFrame.isAfter(@, comparedDate)
  isSame: (comparedDate) ->
    TimeFrame.isSame(@, comparedDate)
  isBetween: (startDate, endDate) ->
    TimeFrame.isBetween(@, startDate, endDate)

  @isBefore: (askedDate, comparedDate) ->
    @parser().isBefore(askedDate, comparedDate)
  @isAfter: (askedDate, comparedDate) ->
    @parser().isAfter(askedDate, comparedDate)
  @isSame: (askedDate, comparedDate) ->
    @parser().isSame(askedDate, comparedDate)
  @isBetween: (askedDate, startDate, endDate) ->
    @parser().isBetween(askedDate, startDate, endDate)

  @_parser: null
  @setParser: (parser) ->
    check(parser, TimeFrame.Parser)
    @_parser = parser
  @parser: -> @_parser
