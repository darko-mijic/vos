Package.describe({
  name: 'radiant:vo-date-time',
  summary: 'Value Object: Date and Time value objects',
  version: '0.1.0',
});

Package.onUse(function (api) {
  api.versionsFrom("METEOR@1.0");

  api.use([
    'coffeescript@1.0.10',
    'stevezhu:lodash@3.10.1',
    'check',
    'radiant:domain@0.1.0',
    'momentjs:moment@2.10.6',
  ]);

  api.addFiles([
    // Duration
    'source/duration/duration_namespace.coffee',
    'source/duration/duration_parser.coffee',
    'source/duration/duration.coffee',
    'source/duration/parsers/moment-parser.coffee',
    'source/duration/config.coffee',
    // ISO DayOfWeek
    'source/iso-day-of-week/iso-day-of-week.coffee',
    // Time
    'source/time/time_namespace.coffee',
    'source/time/time_parser.coffee',
    'source/time/time.coffee',
    'source/time/parsers/moment-parser.coffee',
    'source/time/config.coffee',
  ]);
});