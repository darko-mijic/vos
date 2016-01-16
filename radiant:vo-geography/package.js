Package.describe({
  name: 'radiant:vo-geography',
  summary: 'Value Object: Geography oriented value objects',
  version: '0.1.0',
});

Package.onUse(function (api) {
  api.versionsFrom("METEOR@1.0");

  api.use([
    'coffeescript@1.0.10',
    'stevezhu:lodash@3.10.1',
    'check',
    'radiant:domain@0.1.0',
    'radiant:geolib@2.0.18',
    'radiant:vo-geometry@0.1.0',
  ]);

  api.addFiles([
    // ISOCountry
    'source/iso-country/iso-country.coffee',
    'source/iso-country/country_languages_mappings.coffee',
    // Coordinates
    'source/coordinates/elevation.coffee',
    'source/coordinates/latitude.coffee',
    'source/coordinates/longitude.coffee',
    'source/coordinates/coordinates.coffee',
    // Street
    'source/street/street.coffee',
    // GeoJSON
    'source/geojson/geojson.coffee',
    'source/geojson/geojson-feature.coffee',
    // 'source/geojson/geojson-feature-collection.coffee',
    'source/geojson/geojson-line-string.coffee',
    'source/geojson/geojson-multi-line-string.coffee',
    'source/geojson/geojson-point.coffee',
    'source/geojson/geojson-polygon.coffee',
    'source/geojson/geojson-multi-polygon.coffee',
    // ZipCode
    'source/zipcode/zipcode.coffee',
    'source/zipcode/zipcode_validators.coffee',
    // Address
    'source/address/address.coffee',
    // Distance
    'source/distance/distance.coffee',
    'source/distance/distance-between-points.coffee',
  ]);

  api.addFiles([
    'source/zipcode/zipcode_generators.coffee',
  ], 'server');
});