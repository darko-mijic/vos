digit = -> math.randomInt(0, 9)
digitWithoutZero = -> math.randomInt(1, 9)
stringifiedDigit = -> new String(digit())

ZipCode.generators = new Radiant.domain.ValueObjectGenerators()

# Poland
ZipCode.generators.add new ISOCountry('PL').toString(), () ->
  result = stringifiedDigit() + stringifiedDigit() + '-' + stringifiedDigit() + stringifiedDigit() + stringifiedDigit()
  new ZipCode({value: result, country: new ISOCountry('PL')})