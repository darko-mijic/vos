Package.describe({
  name: 'radiant:vo-web',
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
    'radiant:base-helpers@0.1.0',
    'radiant:urijs@1.17.0',
    'radiant:vo-i18n@0.1.0'
  ]);

  api.addFiles([
    // Email Address
    'source/email-address/email-address.coffee',
    // URI
    'source/uri/uri-namespace.coffee',
    'source/uri/uri-parser.coffee',
    'source/uri/uri-scheme.coffee',
    'source/uri/uri-subdomain.coffee',
    'source/uri/uri-port.coffee',
    'source/uri/uri.coffee',
    'source/uri/parsers/urijs-parser.coffee',
    // Website
    'source/website/website.coffee',
    'source/website/i18n-website.coffee',
    // Slug
    'source/slug/slug.coffee',
    'source/slug/transliteration_mappings.coffee',
    'source/slug/distinct-slug.coffee',
  ]);
});