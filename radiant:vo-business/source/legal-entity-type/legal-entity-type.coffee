# https://en.wikipedia.org/wiki/Types_of_business_entity
class @BusinessLegalEntityType extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'BusinessLegalEntityType'
  # EJSON serializable fields
  fields: ->
    type : String
    country: ISOCountry

  constructor: (data) ->
    super(data)

    BusinessLegalEntityType.validate(data)
    Object.freeze(@)

  toString: -> @type
  isPartnership: ->
    BusinessLegalEntityType.jurisdictions.get(@country.toString()).isPartnership(@type)

  @validate: (data) ->
    jurisdiction = @jurisdictions.get(data.country.toString())

    unless jurisdiction.isAllowed(data.type)
      throw new Error(@ERRORS.invalidLegalType)
    return true

  @types: (isoCountry) -> @jurisdictions.get(isoCountry.toString()).types()
  @isAllowed: (type, isoCountry) ->
    jurisdiction = @jurisdictions.get(isoCountry.toString())
    jurisdiction.isAllowed(type)

  @ERRORS:
    invalidLegalType: 'Legal type not supported in specified country'

BusinessLegalEntityType.jurisdictions =
  _container: {}
  exists: (isoCountry) -> (@_container[isoCountry.toString()]?)
  add: (jurisdiction, override=false) ->
    check(jurisdiction, BusinessLegalEntityType.Jurisdiction)
    if @exists(jurisdiction.country()) and override != true
      throw new Error(@ERRORS.jurisdictionExists)
    @_container[jurisdiction.country().toString()] = jurisdiction
  override: (jurisdiction) -> @add(jurisdiction, true)
  get: (isoCountry) ->
    unless @exists(isoCountry)
      throw new Error(@ERRORS.jurisdictionNotFound)

    return @_container[isoCountry.toString()]
  ERRORS:
    jurisdictionNotFound: 'Jurisdiction does not exists'
    jurisdictionExists: 'Jurisdiction already exists'

