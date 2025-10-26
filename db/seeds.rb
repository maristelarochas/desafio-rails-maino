# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(email: 'johndoe@email.com') do |user|
  user.name = 'John Doe'
  user.password = 'senha123'
end

user = User.find_or_create_by!(email: 'janedoe@email.com') do |user|
  user.name = 'Jane Doe'
  user.password = 'senha123'
end

categories = [ "Ação", "Comédia", "Drama", "Terror", "Ficção Científica", "Romance", "Animação", "Documentário", "Fantasia", "Suspense" ]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

10.times do |i|
  Movie.find_or_create_by!(
    title: Faker::Movie.title,
    synopsis: Faker::Lorem.paragraph(sentence_count: 5),
    release_year: rand(1895..2025),
    duration: rand(80..180),
    director: Faker::Name.name,
    user: user
  )
end
