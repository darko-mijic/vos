# Polish Nin (called PESEL)
NIN.validators.add new ISOCountry('PL').toString(), (value) ->
  pattern = /^[0-9]{11}$/

  if pattern.test(value) == false
    false
  else
    dig = ('' + value).split('')
    checksum = (1 * parseInt(dig[0]) + 3 * parseInt(dig[1]) + 7 * parseInt(dig[2]) + 9 * parseInt(dig[3]) + 1 * parseInt(dig[4]) + 3 * parseInt(dig[5]) + 7 * parseInt(dig[6]) + 9 * parseInt(dig[7]) + 1 * parseInt(dig[8]) + 3 * parseInt(dig[9])) % 10
    if checksum == 0
      checksum = 10
    checksum = 10 - checksum
    if parseInt(dig[10]) == checksum
      true
    else
      false