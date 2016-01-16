Package.describe({
  name: 'radiant:vo-geometry',
  summary: 'Value Object: Geometry oriented value objects',
  version: '0.1.0',
});

Package.onUse(function (api) {
  api.versionsFrom("METEOR@1.0");

  api.use([
    'coffeescript@1.0.10',
    'stevezhu:lodash@3.10.1',
    'check',
    'radiant:domain@0.1.0',
  ]);

  api.addFiles([
    'source/length-unit/length-unit.coffee',

    'source/length/length.coffee',
    'source/radius/radius.coffee',
    'source/diameter/diameter.coffee',
  ]);
});