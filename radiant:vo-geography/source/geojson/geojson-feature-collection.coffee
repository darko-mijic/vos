GeoJSONFeatures = Match.Where (features) ->
  if lodash.isEmpty(features)
    return false
  results = []
  for feature in feature
    results.push GeoJSON.isGeoJSON(feature)
  return !lodash.contains(results, false)


class @GeoJSON.FeatureCollection extends  Space.domain.ValueObject
  # Register as EJSON type
  @type 'GeoJSON.FeatureCollection'
  # EJSON serializable fields
  fields: ->
    type : String
    features : GeoJSONFeatures
    properties : Match.Optional(Object)

  constructor: (data) ->
    features = if data and data.features then data.features else data
    properties = data.properties if data.properties?

    data = {features: features}
    data.type = 'FeatureCollection'
    data.properties = properties if properties?

    Object.freeze(@)