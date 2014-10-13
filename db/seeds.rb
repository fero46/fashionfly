Scope.where(country_code: 'DE', locale:'de').first_or_create
Scope.where(country_code: 'US', locale:'en-us').first_or_create
Scope.where(country_code: 'GB', locale:'en').first_or_create
Configuration.where(key: 'default_country_code', value: 'de').first_or_create