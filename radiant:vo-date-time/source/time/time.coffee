###
https://en.wikipedia.org/wiki/ISO_8601#Times

Keep in mind that ISO 8601 uses 24 hour clock time (24 is not used per say):
"[hh] refers to a zero-padded hour between 00 and 24 (where 24 is only used to
denote midnight at the end of a calendar day).""
###
class @Time extends Time
  # Register as EJSON type
  @type 'Time'
  # EJSON serializable fields
  fields: ->
    value: String

  constructor: (data) ->
    value = if data and data.value then data.value else data

    unless Time.isValid(value)
      throw new Error(Time.ERRORS.invalidTimeFormat)

    @value = value
    Object.freeze(@)

  toString: -> @value
  toNumber: -> Number(@value.replace(':', '').replace('.', ''))

  hours: -> Time.parser().parse(@).hours
  minutes: -> Time.parser().parse(@).minutes
  seconds: -> Time.parser().parse(@).seconds
  milliseconds: -> Time.parser().parse(@).milliseconds

  isBefore: (comparedTime) ->
    Time.isBefore(@, comparedTime)
  isAfter: (comparedTime) ->
    Time.isAfter(@, comparedTime)
  isSame: (comparedTime) ->
    Time.isSame(@, comparedTime)
  isBetween: (startTime, endTime) ->
    Time.isBetween(@, startTime, endTime)

  # hh:mm:ss.sss
  @_pattern: /^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)?(\.?\d{1,3}?)$/
  @isValid: (time) ->
    lodash.isString(time) and @_pattern.test(time)

  @isBefore: (askedTime, comparedTime) ->
    @parser().isBefore(askedTime, comparedTime)
  @isAfter: (askedTime, comparedTime) ->
    @parser().isAfter(askedTime, comparedTime)
  @isSame: (askedTime, comparedTime) ->
    @parser().isSame(askedTime, comparedTime)
  @isBetween: (askedTime, startTime, endTime) ->
    @parser().isBetween(askedTime, startTime, endTime)

  @_parser: null
  @setParser: (parser) ->
    check(parser, Time.Parser)
    @_parser = parser
  @parser: -> @_parser

  @ERRORS:
    invalidFormattedTime: 'Time must fallow ISO 8601 format: hh:mm:ss.sss'