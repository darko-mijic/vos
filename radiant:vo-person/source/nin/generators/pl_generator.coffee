digit = -> math.randomInt(0, 9)
digitWithoutZero = -> math.randomInt(1, 9)
stringifiedDigit = -> new String(digit())
getLetter = (letters) ->
  letters = letters || 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  length = letters.length
  i = Math.floor(Math.random() * length);
  return letters[i]

NIN.generators = new Radiant.domain.ValueObjectGenerators()

# Poland (PESEL)
NIN.addGenerator new ISOCountry('PL').toString(), (date, isoGender) ->
  check(date, Date)
  check(isoGender, ISOGender)

  weights = [(1, 3, 7, 9, 1, 3, 7, 9, 1, 3)]

  fullYear = date.getFullYear()
  year = fullYear % 100
  month = date.getMonth()+1
  day = date.getDate()

  if fullYear >= 1800 and fullYear <= 1899
    month += 80
  else if fullYear >= 2000 and fullYear <= 2099
    month += 20
  else if fullYear >= 2100 and fullYear <= 2199
    month += 40
  else if fullYear >= 2200 and fullYear <= 2299
    month += 60

  digits = [(Math.floor(year / 10), year % 10, Math.floor(month / 10), month % 10, Math.floor(day / 10), day % 10)]
  i = digits.length
  while i < weights.length - 1
    digits[i] = getDigit()
    i++
  if isoGender.isMale()
    digits[weights.length - 1] = getLetter('13579')
  else if isoGender.isFemale()
    digits[weights.length - 1] = getLetter('02468')
  else
    digits[weights.length - 1] = getDigit()

  checksum = 0
  for i in digits
    checksum += weights[i] * digits[i]
  checksum = (10 - (checksum % 10)) % 10

  result = ''
  for i in digits
    result += String(digits[i])
  result += String(checksum)

  return result
