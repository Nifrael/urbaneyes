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
  address: "1 Pl. de la Comédie, 69001 Lyon",
  user_id: user.id
)

ticket1.status_pending!
ticket1.save
ticket1.damage!
ticket1.save

ticket2 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  address: "11 W 53rd St, New York, NY 10019, Stati Uniti",
  user_id: user.id
)

ticket2.status_pending!
ticket2.save
ticket2.upgrade!
ticket2.save


ticket3 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  address: "Süleymaniye, Mimar Sinan Cd. No:20, 34116 Fatih/İstanbul, Turchia",
  user_id: user.id
)

ticket3.status_pending!
ticket3.save
ticket3.upgrade!
ticket3.save


ticket4 = Ticket.create(
  total_votes: Faker::Number.number(digits: 2),
  description: Faker::Markdown.emphasis,
  address: "3 Jervois Quay, Wellington Central, Wellington 6011, Nuova Zelanda",
  user_id: user.id
)

ticket4.status_pending!
ticket4.save
ticket4.damage!
ticket4.save

puts "----------------------------------------------------------------"
puts "#{Ticket.count} Tickets created!"
puts "----------------------------------------------------------------"
