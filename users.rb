require 'yaml'
require 'ffaker'

# NB - remove the dashes before trying to load into the YAML parser in Meteor/Ruby.
# Deleted users: 70, 94, 272 as Meteor parsed them weirdly.

out = File.new "users.yml", "w"

(1..280).each do |i|
    user =  {"user_#{i}" => ["username" => Faker::Internet.user_name(Faker::HipsterIpsum.words(2).to_s[0..19])+rand(9).to_s, "password" => Faker::Internet.password[0..7]] }
    user.to_yaml(out)
end
