# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Ticket.destroy_all
Vote.destroy_all
Comment.destroy_all
User.destroy_all

puts "----------------------------------------------------------------"
puts "Records destroyed"
puts "----------------------------------------------------------------"

puts "----------------------------------------------------------------"
puts "Creating users..."
puts "----------------------------------------------------------------"

user = User.create(email: "test@gmail.com", password: "test1234")

puts "----------------------------------------------------------------"
puts "#{User.count} Users created"
puts "----------------------------------------------------------------"

puts "----------------------------------------------------------------"
puts "Creating tickets..."
puts "----------------------------------------------------------------"

ticket1 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  location: Faker::Address.full_address,
  user_id: user.id
)

ticket1.pending!
ticket1.save
ticket1.damage!
ticket1.save

ticket2 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  location: Faker::Address.full_address,
  user_id: user.id
)

ticket2.pending!
ticket2.save
ticket2.upgrade!
ticket2.save


ticket3 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  location: Faker::Address.full_address,
  user_id: user.id
)

ticket3.pending!
ticket3.save
ticket3.upgrade!
ticket3.save


ticket4 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  location: Faker::Address.full_address,
  user_id: user.id
)

ticket4.pending!
ticket4.save
ticket4.damage!
ticket4.save

puts "----------------------------------------------------------------"
puts "#{Ticket.count} Tickets created!"
puts "----------------------------------------------------------------"
