# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

c1 = Cocktail.create(name: 'Gin & Tonic')
c2 = Cocktail.create(name: 'Manhattan')
c3 = Cocktail.create(name: 'Margherita')

i1 = Ingredient.create(name: 'Gin')
i2 = Ingredient.create(name: 'Tonic')
i3 = Ingredient.create(name: 'Tequilla')

Dose.create(cocktail: c1, ingredient: i1, amount: rand(10..100))
Dose.create(cocktail: c1, ingredient: i2, amount: rand(10..100))
Dose.create(cocktail: c2, ingredient: i2, amount: rand(10..100))
Dose.create(cocktail: c3, ingredient: i3, amount: rand(10..100))

