class @Duration.MomentParser extends Duration.Parser
  _moment: moment

  parse: (durationData) ->
    parsedDuration = @_createMomentDuration(durationData)

    data = {}
    data.years        = parsedDuration.years()
    data.months       = parsedDuration.months()
    data.weeks        = parsedDuration.weeks()
    data.days         = parsedDuration.days()
    data.hours        = parsedDuration.hours()
    data.minutes      = parsedDuration.minutes()
    data.seconds      = parsedDuration.seconds()
    data.milliseconds = parsedDuration.milliseconds()

    return data

  add: (baseDuration, duration) ->
    parsedBaseDuration = @_createMomentDuration(baseDuration)
    parsedDuration = @_createMomentDuration(duration)

    parsedDuration.add(parsedBaseDuration)
  subtract: (baseDuration, duration) ->
    parsedBaseDuration = @_createMomentDuration(baseDuration)
    parsedDuration = @_createMomentDuration(duration)

    parsedDuration.subtract(parsedBaseDuration)

  _createMomentDuration: (durationObject) ->
    moment.duration(durationObject)
