# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Vote.destroy_all
Comment.destroy_all
Ticket.destroy_all
User.destroy_all

puts "----------------------------------------------------------------"
puts "Records destroyed"
puts "----------------------------------------------------------------"

puts "----------------------------------------------------------------"
puts "Creating users..."
puts "----------------------------------------------------------------"

ricardo = User.create(
  first_name: "Ricardo",
  last_name: "Canas",
  address: "9 Rue des Tuileries, 69009 Lyon",
  email: "ricardo@gmail.com",
  password: "test1234",
  photo: ""
)

albert = User.create(
  first_name: "Albert",
  last_name: "Nikolli",
  address: "9 Rue Anselme, 69004 Lyon",
  email: "albert@gmail.com",
  password: "test1234",
  photo: ""
)

julien = User.create(
  first_name: "Julien",
  last_name: "Marchand",
  address: "9 Av. de Ménival, 69005 Lyon",
  email: "julien@gmail.com",
  password: "test1234",
  photo: ""
)

katniss = User.create(
  first_name: "Katniss",
  last_name: "Everdeen",
  address: "9 Rue de la Paix, 69500 Bron",
  email: "katniss@gmail.com",
  password: "test1234",
  photo: ""
)

leia = User.create(
  first_name: "Leia",
  last_name: "Organa",
  address: "9 Rue de la République, 69001 Lyon",
  email: "leia@gmail.com",
  password: "test1234",
  photo: ""
)

dolores = User.create(
  first_name: "Dolores",
  last_name: "Ombrage",
  address: "9 Rue Duquesne, 69006 Lyon",
  email: "dolores@gmail.com",
  password: "test1234",
  photo: ""
)

puts "----------------------------------------------------------------"
puts "#{User.count} Users created"
puts "----------------------------------------------------------------"

puts "----------------------------------------------------------------"
puts "Creating tickets..."
puts "----------------------------------------------------------------"

ticket1 = Ticket.create(
  title: "Panneau publicitaire pour GTA VI",
  total_votes: Faker::Number.number(digits: 2),
  description: "GTA VI sort bientôt, un gros panneau publicitaire pour rendre hommage à ce futur chef d'oeuvre doit être érigé ici!",
  address: "Rue de la République, 69002 Lyon",
  category: "upgrade",
  status: "pending",
  user_id: ricardo.id
)

ticket2 = Ticket.create(
  title: "Escaliers de l'Opéra détériorés",
  total_votes: Faker::Number.number(digits: 2),
  description: "Les escaliers devant l'Opéra sont en train de se fissurer.",
  address: "1 Pl. de la Comédie, 69001 Lyon",
  category: "damage",
  status: "pending",
  user_id: albert.id
)

ticket3 = Ticket.create(
  title: "Anfield à Lyon",
  total_votes: Faker::Number.number(digits: 2),
  description: "Faire de Lyon la ville d'accueil française des joueurs de Liverpool.",
  address: "353 Av. Jean Jaurès, 69007 Lyon",
  category: "upgrade",
  status: "pending",
  user_id: julien.id
)

ticket4 = Ticket.create(
  title: "Traces de bombardement anciens",
  total_votes: Faker::Number.number(digits: 2),
  description: "Des restes d'un bombardement de la Seconde Guerre Mondiale marquent encore les trottoirs proches de la gare.",
  address: "2 Pl. de Paris, 69009 Lyon",
  category: "damage",
  status: "pending",
  user_id: katniss.id
)

ticket5 = Ticket.create(
  title: "Centre de correction des jeunes",
  total_votes: Faker::Number.number(digits: 2),
  description: "Nos jeunes sont indisciplinés, il faut un centre pour les remettre dans le droit chemin!",
  address: "Pl. Bellecour, 69002 Lyon",
  category: "upgrade",
  status: "pending",
  user_id: dolores.id
)

ticket6 = Ticket.create(
  title: "Réparation des lumières du Musée",
  total_votes: Faker::Number.number(digits: 2),
  description: "Les lumières du Musée sont éteintes, faisant du Musée l'Etoile Noire lorsque le soleil est couché.",
  address: "25 Rue du Premier Film, 69008 Lyon",
  category: "damage",
  status: "pending",
  user_id: leia.id
)

puts "----------------------------------------------------------------"
puts "#{Ticket.count} Tickets created!"
puts "----------------------------------------------------------------"

puts "----------------------------------------------------------------"
puts "Creating comments..."
puts "----------------------------------------------------------------"

comment1 = Comment.create(
  user_id: ricardo.id,
  ticket_id: ticket3.id,
  content: "Et pourquoi ce ne serait pas l'Estadio da Luz à Lyon ? Je suis contre."
)

comment2 = Comment.create(
  user_id: albert.id,
  ticket_id: ticket6.id,
  content: "Les artistes montrent la voie, il vaut mieux qu'elle soit allumée."
)

comment3 = Comment.create(
  user_id: julien.id,
  ticket_id: ticket5.id,
  content: "Avec tout le respect que je pourrais devoir à Mme Ombrage, c'est une vieille harpie."
)

comment4 = Comment.create(
  user_id: katniss.id,
  ticket_id: ticket2.id,
  content: "Encore un coup de Coriolanus Snow. Son but est de détruire Lyon pour construire Panem."
)

comment5 = Comment.create(
  user_id: dolores.id,
  ticket_id: ticket1.id,
  content: "Je suis choquée qu'un tel jeu vidéo puisse être promu en plein centre ville, les jeunes sont déjà assez dissipés comme ça!"
)

comment6 = Comment.create(
  user_id: leia.id,
  ticket_id: ticket4.id,
  content: "Il ne faut jamais oublier notre sombre passé. Katniss, vous êtes mon seul espoir."
)

puts "----------------------------------------------------------------"
puts "#{Comment.count} Comments created!"
puts "----------------------------------------------------------------"
