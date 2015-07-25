# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Boiler.create(name: 'PEK45-20.1942-3003', shortname: 'PEK45', ipaddress: '192.168.0.36', logging: true);
Boiler.create(name: 'PC20-12.8956-1907', shortname: 'PC20', ipaddress: '192.168.0.37', logging: false);
