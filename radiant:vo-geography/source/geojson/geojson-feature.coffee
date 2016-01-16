GeoJSONGeometry = Match.Where (geoJSON) ->
  unless geoJSON then return true # Its optional
  GeoJSON.isGeoJSON(geoJSON)

class @GeoJSON.Feature extends Space.domain.ValueObject
  # Register as EJSON type
  @type 'GeoJSON.Feature'
  # EJSON serializable fields
  fields: ->
    type : String
    geometry : GeoJSONGeometry
    properties : Match.Optional(Object)

  constructor: (data) ->
    geometry = if data and data.geometry then data.geometry else data
    properties = data.properties if data.properties?

    data = {geometry: geometry}
    data.type = 'Feature'
    data.properties = properties if properties?

    super(data)
    Object.freeze(@)