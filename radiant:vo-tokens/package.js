Package.describe({
  name: 'radiant:vo-tokens',
  summary: 'Value Object: Most common Token a-type value objects',
  version: '0.1.0',
});

Package.onUse(function (api) {
  api.versionsFrom("METEOR@1.0");

  api.use([
    'check',
    'random',
    'coffeescript@1.0.10',
    'stevezhu:lodash@3.10.1',
    'radiant:domain@0.1.0',
  ]);

  api.addFiles([
    'source/token/token.coffee',
    'source/alphanumeric/alphanumeric.coffee',
    'source/digit/digit.coffee',

    'source/email/email.coffee',
    'source/phone-call/phone-call.coffee',
    'source/post-card/post-card.coffee',
    'source/sms/sms.coffee',
  ]);
});