# Poland (same as TIN == NIP)
VATIN.validators.add(
  new ISOCountry('PL').toString(),
  TIN.validators.get(new ISOCountry('PL').toString())
)
