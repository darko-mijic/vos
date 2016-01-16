class @Diameter extends Length
  radius: -> new Radius({value: @value / 2, unit: @unit})
  convert: (unit) -> Diameter.convert(@, unit)

Diameter.ERRORS.invalid = 'Length must be instance of Diameter'