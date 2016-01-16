Package.describe({
  name: 'radiant:vo-i18n',
  summary: 'Value Object: i18n oriented value objects',
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
    // i18n Value Object
    'source/i18n-vo/i18n-vo.coffee',
    // ISOLanguage
    'source/iso-language/iso-language.coffee',
    'source/iso-language/iso-language_dialects.coffee',
    'source/iso-language/iso-language_three_letter_codes.coffee',
    // Sentence
    'source/sentence/sentence.coffee',
    'source/sentence/i18n-sentence.coffee',
    // Translation
    'source/translation/detected-language.coffee',
    'source/translation/translation.coffee',
  ]);
});