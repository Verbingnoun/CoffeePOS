
require 'csv'

class Coffee
    def initialize
    end

    def coffeeOrder
        puts "\e[H\e[2J"
        puts "What type of coffee?"
        @type = gets.chomp.downcase
        puts "What size?"
        @size = gets.chomp.downcase
        puts "Milk?"
        @milk = gets.chomp.downcase
        puts "Sugar?"
        @sugar = gets.chomp.downcase
        puts "Enter loyalty card number if available"
        @loyalty = gets.chomp.to_i
        puts "#{@size} #{@type} with #{@milk} and #{@sugar}"
        puts "Is this order correct?"
        response = gets.chomp.downcase
        if response == "yes"
            mainMenu
        else
            coffeeOrder
        end

    end

    def addToSales
        # read @size and add to relavent row in sales.csv
    end

    def orderTotal
        #read size of coffee and display price to user
    end

    def loyaltyCheck
        #read csv and check if this is the 5th coffee ordered. If not, add one to csv total
    end

end