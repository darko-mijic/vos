# Poland (NIP)
TIN.validators.add new ISOCountry('PL').toString(), (value) ->
  pattern = /^[0-9]{10}$/

  tinWithoutDashes = value.replace(/-/g, '')
  if pattern.test(tinWithoutDashes) == false
    false
  else
    checksum = 6 * value[0] +
    5 * value[1] +
    7 * value[2] +
    2 * value[3] +
    3 * value[4] +
    4 * value[5] +
    5 * value[6] +
    6 * value[7] +
    7 * value[8]
    checksum %= 11

    return (Number(value[9]) == Number(checksum))