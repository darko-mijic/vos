# http://en.wikipedia.org/wiki/ISO/IEC_5218
class @ISOHumanGender extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'ISOHumanGender'
  # EJSON serializable fields
  fields: ->
    code: Number
    gender: String

  @TYPES: {
    'not known'      : 0
    'male'           : 1
    'female'         : 2
    'not applicable' : 9
  }

  constructor: (data) ->
    gender = if data and data.gender then data.gender else data
    if lodash.isNumber(gender)
      data =
        code: gender
        gender: ISOHumanGender.ISOnumberToGender(gender)
    if lodash.isString(gender)
      data =
        code: ISOHumanGender.typeToISONumber(gender)
        gender: gender

    unless ISOHumanGender.isValidCode(data.code)
      throw new Error(ISOHumanGender.ERRORS.invalidISOCode)

    unless ISOHumanGender.isValidGender(data.gender)
      throw new Error(ISOHumanGender.ERRORS.invalidGenderType)

    super(data)
    Object.freeze(@)

  isMale   : -> @code == @TYPES['male']
  isFemale : -> @code == @TYPES['female']
  isNA     : -> @code == @TYPES['not known']
  toString : -> @gender

  @createMale: -> new ISOHumanGender(ISOHumanGender.TYPES.male)
  @createFemale: -> new ISOHumanGender(ISOHumanGender.TYPES.female)
  @typeToISONumber: (gender) ->
    unless @TYPES[gender]
      throw new Error(@ERRORS.invalidGenderType)
    @TYPES[gender]

  @ISOnumberToGender: (number) ->
    numberedMappings = lodash.invert(@TYPES)
    unless @numberedMappings[number]
      throw new Error(@ERRORS.invalidISOCode)
    @numberedMappings[number]

  @isValidCode: (code) -> (code in lodash.values(@TYPES))
  @isValidGender: (gender) -> (gender in lodash.keys(@TYPES))

  @ERRORS:
    invalidISOCode: 'Invalid human gender ISO/IEC 5218 code'
    invalidGenderType: 'Invalid human gender type'
