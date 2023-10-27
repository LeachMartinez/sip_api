# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

##
# main user
User.create(username: "leachsze", email: "andreysunone@gmail.com", first_name: "Andrey", last_name: "Sunsin", password: "200116")

##
# Test users list
for i in (1..100) do
  username = Faker::Internet.username
  email = Faker::Internet.email(name: username, domain: "gmail.com")
  avatar = Faker::Avatar.image
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  pwd = Faker::Internet.password

  User.create(username: username, email: email, first_name: first_name, last_name: last_name, password: pwd, avatar: avatar)
end
