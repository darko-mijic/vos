# http://geojson.org/geojson-spec.html
# http://www.macwright.org/2015/03/23/geojson-second-bite.html#coordinate
# http://www.macwright.org/lonlat/
# [EXAMPLES] http://geojsonlint.com/
class @GeoJSON
  @_geormetries: {}
  @geometries: -> @_geormetries
  @addGeometery: (type, geometry) ->
    type = geometry.type unless type?
    if @isGeometry(type)
      throw new Error(GeoJSON.ERRORS.geometryExists)
    @_geormetries[type] = geometry
  @geometry: (type) ->
    unless @isGeometry(type)
      throw new Error(GeoJSON.ERRORS.geometryExists)
    @_geormetries[type]
  @isGeometry: (type) -> (@_geormetries[type]?)
  @isGeoJSON: (geoJSON) ->
    unless lodash.isObject(geoJSON) then return false

    unless geoJSON.type? then return false
    type = geoJSON.type
    unless @isGeometry(type) then return false

    return @geometry(type).is(geoJSON)
  @isCoordinates: (coordinates) -> coordinates instanceof Coordinates

  @ERRORS:
    geometryExists: 'GeoJSON geometry already exists'