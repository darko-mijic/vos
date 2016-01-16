Package.describe({
  name: 'radiant:vo-communication',
  summary: 'Value Object: Communication oriented value objects',
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
    'radiant:vo-geography@0.1.0',
  ]);

  api.addFiles([
    'source/phone-number/phone-number_namespace.coffee',
    'source/phone-number/phone-number-carrier.coffee',
    'source/phone-number/phone-number-type.coffee',
    'source/phone-number/phone-number.coffee',
  ]);
});