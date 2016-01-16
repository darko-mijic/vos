class BusinessLegalEntityType.Jurisdiction
  constructor: (isoCountry) ->
    check(isoCountry, ISOCountry)

    @_country = isoCountry
    @_types = []
    @_partnership = []

  country :-> @_country
  types: -> @_types
  partnership: -> @_partnership

  isAllowed: (type) -> type in @_types
  setAllowedLegalTypes: (types=[]) -> @_types = types
  addAllowedLegalType: (type) -> @_types.push(type)
  removeAllowedLegalType: (type) -> lodash.pull(@_types, type)

  isPartnership: (type) -> type in @_partnership
  setPartnershipLegalTypes: (types=[]) -> @_partnership = types
  addPartnershipLegalType: (type) -> @_partnership.push(type)
  removePartnershipLegalType: (type) -> lodash.pull(@_partnership, type)