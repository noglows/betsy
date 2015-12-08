# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_categories = [
  { name: "stuffed animals" },
  { name: "stickers" },
  { name: "clothing" },
  { name: "slippers" },
  { name: "socks" },
]

seed_categories.each do |seed|
  Category.create(seed)
end

seed_users = [
  { first_name: "Daphne", last_name: "Gold", email: "1@1.com" },
  { first_name: "Amy", last_name: "Hunter", email: "2@2.com" },
  { first_name: "Jessica", last_name: "Noglows", email: "3@3.com" },
  { first_name: "Lauren", last_name: "Granger", email: "4@4.com" },
  { first_name: "Mystery Person", last_name: "Mystery", email: "5@5.com" }
]

seed_users.each do |seed|
  user = User.create(seed)
  user.password = "1"
  user.save
end
