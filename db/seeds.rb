# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password')

user.family_cards.create!(parent_first_name: 'John', parent_last_name: 'Smith', student_name: 'Sally Student', phone: '215-804-9408', email: 'smiths@example.com', address1: '312 West Broad Street', address2: 'In the back', city: 'Quakertown', state: 'PA', zip_code: '18951')
