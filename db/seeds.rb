# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Person.destroy_all
Debt.destroy_all

User.create email: 'admin@admin.com', password: '111111', password_confirmation: '111111'

# puts "Usuário criado:"
# puts "login admin@admin.com"
# puts "111111"

# Seed Users
100.times do
  new_user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )

  new_user.save

  puts "Usuário criado:"
  puts new_user.to_s
end

# Seed data
100.times do
  new_person = Person.new(
    name: Faker::Name.name,
    national_id: CPF.generate,
    phone_number: Faker::PhoneNumber.phone_number,
    active: Faker::Boolean.boolean,
    user: User.order("RANDOM()").first,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )

  new_person.save

  puts "Pessoa criada:"
  puts new_person.to_s
end

# Seed Debts
100.times do
  new_debt = Debt.new(
    person: Person.order("RANDOM()").first,
    amount: Faker::Number.decimal(l_digits: 2),
    observation: Faker::Lorem.sentence,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )

  puts "Débito created:"
  puts new_debt.to_s
end