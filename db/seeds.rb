require 'json'
require 'open-uri'
system 'clear'


puts "Destroying all Doses in database..... (and 'doses' is a retarded word for this join table)"
Dose.destroy_all
puts "     - All Doses deleted.\n\n"

puts 'Destroying all Ingredients in database.....'
Ingredient.destroy_all
puts "     - All Ingredients deleted.\n\n"

puts 'Destroying all Cocktails in database.....'
Cocktail.destroy_all
puts "     - All Cocktails deleted.\n\n"

puts 'Seeding Ingredients.....'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_list_serialized = open(url).read
ingredient_list = JSON.parse(ingredient_list_serialized)

ingredient_list['drinks'].each do |hash|
  ingredient_name = hash['strIngredient1']
  new_ingredient = Ingredient.new(name: ingredient_name)
  new_ingredient.save!
end
puts "     - #{Ingredient.count} Ingredients Populated!\n\n"

puts 'Seeding Cocktails.....'
url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'
cocktail_list_serialized = open(url).read
cocktail_list = JSON.parse(cocktail_list_serialized)

cocktail_list['drinks'].each do |hash|
  drink_name = hash['strDrink']

  drink_details_url = URI.parse(URI.escape("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink_name}"))
  drink_details_serialized = open(drink_details_url).read
  drink_details = JSON.parse(drink_details_serialized)

  drink_photo = drink_details['drinks'][0]['strDrinkThumb']
  new_cocktail = Cocktail.new(name: drink_name, photo_link: drink_photo)
  new_cocktail.save!
end
puts "     - #{Cocktail.count} Cocktails Populated!\n\n"

puts 'Seeding Doses.....'
cocktail_list = Cocktail.all
# url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'
# cocktail_list_serialized = open(url).read
# cocktail_list = JSON.parse(cocktail_list_serialized)
# cocktail_list['drinks'].each do |hash|
cocktail_list.each do |hash|
  # drink_name = hash['strDrink']
  drink_name = hash[:name]

  drink_details_url = URI.parse(URI.escape("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink_name}"))
  drink_details_serialized = open(drink_details_url).read
  drink_details = JSON.parse(drink_details_serialized)

  ingredients_array = []
  description_array = []

  i = 1
  15.times do
    ingredients_array << drink_details['drinks'][0]["strIngredient#{i}"].strip unless drink_details['drinks'][0]["strIngredient#{i}"].nil?
    description_array << drink_details['drinks'][0]["strMeasure#{i}"].strip unless drink_details['drinks'][0]["strIngredient#{i}"].nil?
    i += 1
  end

  ingredients_array.each_with_index do |ingredient, index|
    if ingredient.length.positive?

      if Ingredient.where(name: ingredient).ids.join.to_i.zero?
        new_ingredient = Ingredient.new(name: ingredient)
        new_ingredient.save!
      end

      new_dose = Dose.new(description: description_array[index].length.zero? ? 'Plus...' : description_array[index],
                          cocktail_id: Cocktail.where(name: drink_name).ids.join.to_i,
                          ingredient_id: Ingredient.where(name: ingredient).ids.join.to_i)
      new_dose.save!
    end
  end
end
puts "     - #{Dose.count} Doses Populated!\n\n"



Collapse 
Message Input

Message brian-welch
