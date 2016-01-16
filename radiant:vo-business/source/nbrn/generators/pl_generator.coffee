NBRN.generators = new Radiant.domain.ValueObjectGenerators()

digit = -> math.randomInt(0, 9)
digitWithoutZero = -> math.randomInt(1, 9)
stringifiedDigit = -> new String(digit())
regionDigits = -> Math.floor(Math.random() * 49) * 2 + 1

# Poland (Regon, wikipedia says Regon is TIN, however its messed up)
NBRN.generators.add new ISOCountry('PL').toString(), (version) ->
  regon9 = ->
    weights = [8, 9, 2, 3, 4, 5, 6, 7]
    region = regionDigits()
    e = [Math.floor(region / 10), region % 10]
    checksum = 2
    while checksum < weights.length
      e[checksum] = digit()
      checksum++
    a = 0
    checksum = 0
    while checksum < e.length
      a += weights[checksum] * e[checksum]
      checksum++
    a %= 11
    if a == 10
      a = 0
    result = ''
    checksum = 0
    while checksum < e.length
      result += String(e[checksum])
      checksum++
    result += String(a)
    return result

  regon14 = ->
    weights = [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8]
    regon = regon9()
    f = []
    checksum = 0
    while checksum < regon.length
      f[checksum] = regon.charAt(checksum)
      checksum++
    checksum = regon.length
    while checksum < weights.length
      f[checksum] = digit()
      checksum++
    a = 0
    checksum = 0
    while checksum < f.length
      a += weights[checksum] * f[checksum]
      checksum++
    a %= 11
    if a == 10
      a = 0
    result = ''
    checksum = 0
    while checksum < f.length
      result += String(f[checksum])
      checksum++
    result += String(a)
    return result

  country = new ISOCountry('PL')
  if version == 9
    new NBRN({nbrn: regon9(), country: country})
  else if version == 14
    new NBRN({nbrn: regon14(), country: country})
  else
    new NBRN({nbrn: regon14(), country: country})

