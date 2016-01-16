class @TimeFrame.MomentParser extends TimeFrame.Parser
  _moment: moment

  _format: null
  format: -> @_format
  _createMoment: (dateObject) ->
    moment(dateObject, @format())

  isBefore: (from, to) ->
    @validateDate(dateObj) for dateObj in [from, to]

    @_createMoment(from).isBefore(@_createMoment(to))

  isAfter: (from, to) ->
    @validateDate(dateObj) for dateObj in [from, to]

    @_createMoment(from).isAfter(@_createMoment(to))

  isSame: (from, to) ->
    @validateDate(dateObj) for dateObj in [from, to]

    @_createMoment(from).isSame(@_createMoment(to))

  isBetween: (askedDate, startDate, endDate) ->
    @validateDate(dateObj) for dateObj in [askedDate, startDate, endDate]

    @_createMoment(askedDate).isBetween(
      @_createMoment(startDate),
      @_createMoment(endDate),
    )

  validateDate: (date) ->
    check(date, Date)