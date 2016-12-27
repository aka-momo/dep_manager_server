# This file should contain all the record creation needed to seed
# the database with its default values.
# The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
# { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Nokigiri
source_url         = 'https://github.com/sparklemotion/nokogiri'
mac_dependencies   = ['libxml2']
linux_dependencies = ['ruby-dev', 'zlib1g-dev', 'liblzma-dev']

p1 = Package.new(language: 1, name: 'nokogiri', source_url: source_url)
linux_dependencies.each do |d|
  p1.system_dependencies.build(name: d, operating_system: 2)
end
mac_dependencies.each do |d|
  p1.system_dependencies.build(name: d, operating_system: 1)
end
p1.save!

# PG
p2 = Package.new(language: 1, name: 'pg', source_url: 'https://github.com/ged/ruby-pg')
p2.system_dependencies.build(name: 'postgresql', operating_system: 1)
p2.save!
