class @Radius extends Length
  diameter: -> new Diameter({value: @value * 2, unit: @unit})
  convert: (unit) -> Radius.convert(@, unit)

Radius.ERRORS.invalid = 'Length must be instance of Radius'