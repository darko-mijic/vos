VATIN.generators = new Radiant.domain.ValueObjectGenerators()

# Poland (same as TIN == NIP)
VATIN.generators.add TIN.generators.get(new ISOCountry('PL').toString())