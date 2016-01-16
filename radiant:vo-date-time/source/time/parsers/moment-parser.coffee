class @Time.MomentParser extends Time.Parser
  _moment: moment

  parse: (timeObject) ->
    @validateTime(timeObject)
    parsedTime = @_createMoment(timeObject)

    data = {}
    data.hours        = parsedTime.hours()
    data.minutes      = parsedTime.minutes()
    data.seconds      = parsedTime.seconds()
    data.milliseconds = parsedTime.milliseconds()
    return data

  _format: 'HH:mm:ss.SSS'
  format: -> @_format
  _createMoment: (timeObject) ->
    moment(timeObject, @format())

  isBefore: (askedTime, comparedTime) ->
    @validateTime(timeObj) for timeObj in [askedTime, comparedTime]

    @_createMoment(askedTime.toString()).isBefore(@_createMoment(comparedTime.toString()))

  isAfter: (askedTime, comparedTime) ->
    @validateTime(timeObj) for timeObj in [askedTime, comparedTime]

    @_createMoment(askedTime.toString()).isAfter(@_createMoment(comparedTime.toString()))

  isSame: (askedTime, comparedTime) ->
    @validateTime(timeObj) for timeObj in [askedTime, comparedTime]

    @_createMoment(askedTime.toString()).isSame(@_createMoment(comparedTime.toString()))

  isBetween: (askedTime, startTime, endTime) ->
    @validateTime(timeObj) for timeObj in [askedTime, startTime, endTime]

    @_createMoment(askedTime.toString()).isBetween(
      @_createMoment(startTime.toString()),
      @_createMoment(endTime.toString()),
    )

  validateTime: (time) ->
    check(time, Time)