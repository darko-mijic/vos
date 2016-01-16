# https://gist.github.com/philipashlock/8830168
class @Duration extends Duration
  # Register as EJSON type
  @type 'Duration'
  # EJSON serializable fields
  fields: ->
    years        : Number
    months       : Number
    weeks        : Number
    days         : Number
    hours        : Number
    minutes      : Number
    seconds      : Number
    milliseconds : Number

  constructor: (args...) ->
    # Case 1: Passed formatted string, number as milliseconds or object
    if args.length == 1
      data = args[0]

      if lodash.isString(data) and not Duration.isValidFormattedDuration(data)
        throw new Error(Duration.ERRORS.invalidFormattedDuration)
    # Case 2: Passed unit - value, like: {seconds: 2}
    else
      data = {}
      data[args[1]] = args[0]

    data = Duration.parser().parse(data)
    super(data)
    Object.freeze(@)


  add: (duration) -> Duration.add(@, duration)
  subtract: (duration) -> Duration.subtract(@, duration)
  @add: (baseDuration, duration) ->
    @validateDuration(baseDuration)
    @validateDuration(duration)

    new Duration(@parser().add(baseDuration, duration))
  @subtract: (baseDuration, duration) ->
    @validateDuration(baseDuration)
    @validateDuration(duration)

    new Duration(@parser().subtract(baseDuration, duration))

  @_patterns: [
    # ASP.NET style time spans
    /^([\d]\.)?[\d]{2}\:[\d]{2}?(\:[\d]{2})?(\.[\d]{3})?$/
    # Duration
    /^(R\d*\/)?P(?:\d+(?:\.\d+)?Y)?(?:\d+(?:\.\d+)?M)?(?:\d+(?:\.\d+)?W)?(?:\d+(?:\.\d+)?D)?(?:T(?:\d+(?:\.\d+)?H)?(?:\d+(?:\.\d+)?M)?(?:\d+(?:\.\d+)?S)?)?$/,
    # Range of Date/Duration
    /^(R\d*\/)?([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\4([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\18[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?(\/)P(?:\d+(?:\.\d+)?Y)?(?:\d+(?:\.\d+)?M)?(?:\d+(?:\.\d+)?W)?(?:\d+(?:\.\d+)?D)?(?:T(?:\d+(?:\.\d+)?H)?(?:\d+(?:\.\d+)?M)?(?:\d+(?:\.\d+)?S)?)?$/,
    # Range of Duration/Date
    /^(R\d*\/)?P(?:\d+(?:\.\d+)?Y)?(?:\d+(?:\.\d+)?M)?(?:\d+(?:\.\d+)?W)?(?:\d+(?:\.\d+)?D)?(?:T(?:\d+(?:\.\d+)?H)?(?:\d+(?:\.\d+)?M)?(?:\d+(?:\.\d+)?S)?)?\/([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\4([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\18[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/
  ]
  @isValidFormattedDuration: (duration) ->
    for pattern in @_patterns
      return true if pattern.test(duration) == true
    return false

  @validateDuration: (duration) ->
    check(duration, Duration)
    return true

  @_parser: null
  @setParser: (parser) ->
    check(parser, Duration.Parser)
    @_parser = parser
  @parser: -> @_parser

  @ERRORS:
    invalidFormattedDuration: 'Duration must be provided as string in format DD.HH:MM:SS.MS'