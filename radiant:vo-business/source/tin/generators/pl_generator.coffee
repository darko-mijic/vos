TIN.generators = new Radiant.domain.ValueObjectGenerators()

digit = -> math.randomInt(0, 9)
digitWithoutZero = -> math.randomInt(1, 9)

# Poland (NIP)
TIN.generators.add new ISOCountry('PL').toString(), () ->
  weights = [6, 5, 7, 2, 3, 4, 5, 6, 7]
  numbers = undefined
  a = undefined
  b = undefined
  loop
    numbers = [digitWithoutZero(), digitWithoutZero(), digitWithoutZero(), digit(), digit(), digit(), digit(), digit(), digit()]
    a = 0
    b = 0
    while b < numbers.length
      a += weights[b] * numbers[b]
      b++
    a %= 11
    unless a == 10
      break
  result = ''
  checksum = 0
  while checksum < numbers.length
    result += new String(numbers[checksum])
    checksum++
  result += new String(a)

  return new TIN({tin: result, country: new ISOCountry('PL')})
