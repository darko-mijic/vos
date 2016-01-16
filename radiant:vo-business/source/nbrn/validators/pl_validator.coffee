# Poland (Regon, wikipedia says Regon is TIN, however its messed up)
# https://pl.wikipedia.org/wiki/REGON
NBRN.validators.add new ISOCountry('PL').toString(), (value) ->
  value = Number(value)

  calculateControlSum = (value, weights=[], offset) ->
    offset = 0 unless offset?
    controlSum = 0

    valueLength = String(value).length
    # Take 13 numbers from value
    for i in [0...valueLength-1]
      controlSum = controlSum + weights[i + offset] * Number(String(value)[i])
    return controlSum

  version = String(value).length
  if version == 7 or version == 9
    weights = [8, 9, 2, 3, 4, 5, 6, 7]
    offset = 9 - version
    controlSum = calculateControlSum(value, weights, offset)
  else if version == 14
    weights = [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8]
    controlSum = calculateControlSum(value, weights)
  else
    return false

  controlNum = controlSum % 11
  if controlNum == 10
    controlNum = 0
  lastDigit = Number(String(value)[String(value).length-1])
  return controlNum == lastDigit
