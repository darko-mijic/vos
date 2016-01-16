# Poland
ZipCode.validators.add(new ISOCountry('PL').toString(), /^[0-9]{2}-[0-9]{3}$/)

# German
ZipCode.validators.add(new ISOCountry('DE').toString(), /^(?!01000|99999)(0[1-9]\d{3}|[1-9]\d{4})$/)