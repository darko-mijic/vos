jurisdiction = new BusinessLegalEntityType.Jurisdiction(new ISOCountry('PL'))
jurisdiction.setAllowedLegalTypes([
  'soleProprietorship'          # jednoosobowa działalność gospodarcza
  'publicLimitedCompany'        # S.A. (spółka akcyjna)
  'civilPartnership'            # s.c. (spółka cywilna)
  'generalPartnership'          # sp.j. (spółka jawna)
  'limitedPartnership'          # sp.k. (spółka komandytowa)
  'limitedLiabilityPartnership' # sp.p. (spółka partnerska)
  'limitedCompany'              # Sp. z o.o. (spółka z ograniczoną odpowiedzialnością)

  'stateEnterprise'             # Przedsiębiorstwo Państwowe
  'voluntaryAssociation'        # Stowarzyszenie
  'cooperative'                 # Spółdzielnia
  'foundation'                  # Fundacja
])
jurisdiction.setPartnershipLegalTypes([
  'publicLimitedCompany'
  'civilPartnership'
  'generalPartnership'
  'limitedPartnership'
  'limitedLiabilityPartnership'
  'limitedCompany'
])
BusinessLegalEntityType.jurisdictions.add(jurisdiction)