OptionalGeometry = Match.Where (geoJSON) ->
  unless geoJSON then return true # Optional
  GeoJSON.isGeoJSON(geoJSON)

class @Address extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'Address'
  # EJSON serializable fields
  fields: ->
    country   : ISOCountry
    city      : Match.Optional(String) # City/Town/Village
    state     : Match.Optional(String) # Region/County/State
    zipCode   : Match.Optional(ZipCode)
    street    : Match.Optional(Street)
    geometry  : Match.Optional(GeoJSON.Point)
    formatted : Match.Optional(String)
    partOf    : Match.Optional(String) # Usefull for shopping malls
    district  : Match.Optional(String) # District/City area
    extra     : Match.Optional(Object)

  constructor: (data) ->
    super(data)
    Object.freeze(@)

  format: ->
    return @formatted if @formatted?

    data = {}
    data.partOf  = @partOf if @partOf?
    data.street  = @street if @street?
    data.city    = @city if @city?
    data.zipCode = @zipCode if @zipCode?
    data.country = @country if @country?

    return @constructor.format(data)

  toString: -> @format()
  @format: (data) ->
    format = ['partOf', 'street', 'city', 'zipCode', 'country']

    parts = []
    for key, value of data
      if key in format
        if lodash.isObject(value)
          parts.push value.toString()
        else
          parts.push value

    return parts.join(', ')
