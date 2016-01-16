Package.describe({
  name: 'radiant:vo-network',
  summary: 'Value Object: Network oriented value objects',
  version: '0.1.0',
});

Package.onUse(function (api) {
  api.versionsFrom("METEOR@1.0");

  api.use([
    'coffeescript@1.0.10',
    'stevezhu:lodash@3.10.1',
    'check',
    'radiant:domain@0.1.0',
    'radiant:base-helpers@0.1.0',
  ]);

  api.addFiles([
    'source/ip-address/ip-address.coffee',
    'source/ip-address/ip-address-v4.coffee',
    'source/ip-address/ip-address-v6.coffee',
  ]);
});