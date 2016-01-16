Package.describe({
  name: 'radiant:vo-person',
  summary: 'Value Object: Person oriented value objects',
  version: '0.1.0',
});

Package.onUse(function (api) {
  api.versionsFrom("METEOR@1.0");

  api.use([
    'coffeescript@1.0.10',
    'stevezhu:lodash@3.10.1',
    'check',
    'radiant:domain@0.1.0',
    'radiant:vo-geography@0.1.0',
  ]);

  api.addFiles([
    // Gender
    'source/iso-human-gender/iso-human-gender.coffee',
    // NIN - national identification number
    'source/nin/nin.coffee',
    'source/nin/validators/pl_validator.coffee',
  ]);

  api.addFiles([
    'source/nin/generators/pl_generator.coffee',
  ], 'server');
});