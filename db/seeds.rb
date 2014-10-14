Scope.where(country_code: 'DE', locale:'de').first_or_create
Scope.where(country_code: 'US', locale:'en-us').first_or_create
Scope.where(country_code: 'GB', locale:'en').first_or_create
Configuration.where(key: 'default_country_code', value: 'de').first_or_create

colors =["e7db9c", "ffff02", "7cfe6f", "ffdfef", "ffdfef", 
         "2ed0cd", "b9531c", "f4cb62", "c61cd0", "ff0000",
         "ffffff", "2c2bd1", "d4d4d4", "ffc702", "000000",
         "019e13", "c5e1fd", "ff59ae", "77858f"]

for color in colors
  Colorization.where(name: "##{color}").first_or_create
end