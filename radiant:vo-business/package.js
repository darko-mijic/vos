Package.describe({
  name: 'radiant:vo-business',
  summary: 'Value Object: Business oriented value objects',
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
    'radiant:vo-date-time@0.1.0',
  ]);

  api.addFiles([
    // TIN - Taxpayer Identification Number
    'source/tin/tin.coffee',
    'source/tin/validators/pl_validator.coffee',
    // NBRN - National Business Registry Number
    'source/nbrn/nbrn.coffee',
    'source/nbrn/validators/pl_validator.coffee',
    // VAT identification number
    'source/vatin/vatin.coffee',
    'source/vatin/validators/pl_validator.coffee',
    // Legal Type
    'source/legal-entity-type/legal-entity-type.coffee',
    'source/legal-entity-type/legal-entity-type_jurisdiction.coffee',
    'source/legal-entity-type/jurisdictions/pl_jurisdiction.coffee',
  ]);

  api.addFiles([
    'source/tin/generators/pl_generator.coffee',
    'source/nbrn/generators/pl_generator.coffee',
    'source/vatin/generators/pl_generator.coffee',
  ], 'server');
});