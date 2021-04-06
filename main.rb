require './classes/coffee.rb'
require 'csv'

# sales = [ {small: 0}, {medium: 0} {large: 0} ]

puts "Welcome to CoffeePOS!"
# puts inventory total for milk, cups and beans

def mainMenu
    puts "\e[H\e[2J"
    puts "-----------------------------------------------"
    puts "1. New Order   2. Inventory  3. Loyalty Program   4. End of day"
    puts "Enter the number of the option you would like"
    puts "-----------------------------------------------"
    action = gets.chomp.downcase 
    if action == "1"
        order = Coffee.new
        order.coffeeOrder
    elsif action == "2"
        # inventory = Inventory.new
    elsif action == "3"
        # loyalty = Loyalty.new
    elsif action == "4"
        # end_of_day = Eod.new
    else
        puts "Please enter 1, 2 or 3"
        mainMenu
    end
end

mainMenu

CSV.read("inventory.csv")