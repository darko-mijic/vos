# https://en.wikipedia.org/wiki/ISO_8601#Week_dates
# "the weekday number, from 1 through 7, beginning with Monday and ending with Sunday."
class @ISODayOfWeek extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'ISODayOfWeek'
  # EJSON serializable fields
  fields: ->
    dayOfWeek: String

  @DAYS_OF_WEEK:
    monday    : 1
    tuesday   : 2
    wednesday : 3
    thursday  : 4
    friday    : 5
    saturday  : 6
    sunday    : 7

  constructor: (data) ->
    dayOfWeek = if data and data.dayOfWeek then data.dayOfWeek else data
    dayOfWeek = ISODayOfWeek.numberToName(dayOfWeek) if lodash.isNumber(dayOfWeek)
    dayOfWeek = dayOfWeek.toLowerCase() if lodash.isString(dayOfWeek)

    @validate(dayOfWeek)

    @dayOfWeek = dayOfWeek
    Object.freeze(@)

  toString: -> @dayOfWeek
  toNumber: -> ISODayOfWeek.nameToNumber(@dayOfWeek)

  @isValid: (dayOfWeek) -> (lodash.isString(dayOfWeek) and dayOfWeek in @names)
  @validate: (dayOfWeek) ->
    unless ISODayOfWeek.isValid(dayOfWeek)
      throw new Error(@ERRORS.invalidDayOfWeek)
    return true
  @names: -> lodash.keys(@DAYS_OF_WEEK)
  @nameToNumber: (dayOfWeek) ->
    @validate(dayOfWeek)
    @DAYS_OF_WEEK[dayOfWeek]
  @numberToName: (number) ->
    unless number > 7
      throw new Error(@ERRORS.invalidDayOfWeekNumber)
    lodash.invert(@DAYS_OF_WEEK)[dayOfWeek]

  @monday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.monday)
  @tuesday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.tuesday)
  @wednesday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.wednesday)
  @thursday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.thursday)
  @friday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.friday)
  @saturday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.saturday)
  @sunday: ->
    new ISODayOfWeek(@DAYS_OF_WEEK.sunday)

  @ERRORS:
    invalidDayOfWeek: 'Invalid day of week'
    invalidDayOfWeekNumber: 'Day of week number must fallow ISO 8601 format (1-7)'