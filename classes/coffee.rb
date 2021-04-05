
require '../csv/sales.csv'

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
        puts "#{@size} #{@type} with #{@milk} and #{@sugar}"
        puts "Is this order correct?"
        response = gets.chomp.downcase
        if response == "yes"
            # puts "Total is "
            # if @size == small
                puts "small"
            mainMenu
        else
            coffeeOrder
        end

    end

    def addToSales
    end

end