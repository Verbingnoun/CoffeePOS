require 'csv'
require 'tty-screen'
require 'tty-box'
require 'colorize'
require 'bundler'
require 'tty-font'
require 'pastel'

inventory = []
loyalty = []
prices = {small: 2, medium: 3, large: 4}
sales_hash = {small: 0, medium: 0, large: 0}

def coffeeOrder(inventory, loyalty, sales_hash, prices)
    order_hash = {}
    loop do
        puts "\e[H\e[2J"
        print "What type of" 
        puts " coffee?".colorize(:red)
        order_hash[:type] = gets.chomp.downcase
        puts "\e[H\e[2J"
        print "What size?" 
        puts " large / medium / small".colorize(:red)
        order_hash[:size] = gets.chomp.downcase
        puts "\e[H\e[2J"
        print "Milk?"
        puts " full cream / soy / no".colorize(:red)
        order_hash[:milk] = gets.chomp.downcase
        puts "\e[H\e[2J"
        print "Sugar?" 
        puts " yes / no".colorize(:red)
        order_hash[:sugar] = gets.chomp.downcase
        puts "\e[H\e[2J"
        puts "Enter loyalty card number if available, else type nil"
        order_hash[:loyalty_num] = gets.chomp
        puts "\e[H\e[2J"
        puts "#{order_hash[:size].colorize(:red)} #{order_hash[:type].colorize(:red)} with #{order_hash[:milk].colorize(:red)} milk and loyalty number #{order_hash[:loyalty_num].colorize(:red)}"
        puts "Is this order correct? yes/no/main-menu"
        response = gets.chomp.downcase
        if response == "yes"
            updated_inventory = removeInventory(inventory, "cups")
            updated_inventory = removeInventory(inventory, "beans")
            if order_hash[:sugar] == "yes"
                updated_inventory = removeInventory(inventory, "sugar")
            end
            if order_hash[:milk] == "full cream" or order_hash[:milk] == "soy"
                updated_inventory = removeInventory(inventory,"milk")
            end
            addToSales(order_hash[:size], sales_hash)
            checkLoyalty(loyalty, order_hash[:loyalty_num], order_hash, prices)
            return updated_inventory
        elsif response == "main-menu"
            return inventory
        end
    end
end

def editInventory(inventory)
    puts "\e[H\e[2J"
    puts "What item would you like to edit? milk/beans/cups/sugar"
    input = gets.chomp
    result = inventory.find { |item| input == item[:name]}
    puts "\e[H\e[2J"
    puts "What is the new quantities of the selected product?"
    input = gets.chomp.to_i
    result[:qty] = input
    puts "\e[H\e[2J"
    puts "#{result[:qty]} units of #{result[:name]}"
    puts "Item successfully edited"
    puts "Press enter to continue"
    gets
    return inventory
end

def addToSales(size, sales_hash)
    sales_hash[size.to_sym] = sales_hash[size.to_sym] + 1
end

def removeInventory(inventory, product)
    result = inventory.find { |item| product == item[:name]  }
    result[:qty] -= 1
    return inventory
end

def printPrice(order_hash, prices_hash)
    size = order_hash[:size]
    puts "Total price is $#{prices_hash[size.to_sym]} "
end

def checkLoyalty(array, loyalty_num, order_hash, prices)
    array.each do |item|
        if loyalty_num == item[:loyalty_number] and item[:qty] == 5
            puts "\e[H\e[2J"
            puts "Loyalty number found"
            puts "Free Coffee! Congratulations"
            item[:qty] = 0
            puts "Press enter to continue"
            gets
            return
        elsif loyalty_num == item[:loyalty_number] and item[:qty] != 5
            item[:qty] += 1
            puts "\e[H\e[2J"
            puts "Loyalty number found"
            puts "#{5 - item[:qty]} more orders till next free coffee"
            printPrice(order_hash, prices)
            puts "Press enter to continue"
            gets
            return
        else
            next
        end
    end

    puts "Loyalty number not found"
        printPrice(order_hash, prices)
        puts "Press enter to continue"
        gets
end


def dayEnd (inventory, loyalty, sales_hash)
    date = Time.new
    date_today = date.strftime("%d_%m_%Y")
    #  write inventory array to inventory.csv
    CSV.open('./csv/inventory.csv', "w") do |csv|
         inventory.each do |item|
        csv << [item[:name], item[:qty]]
        end
    end
    # write loyalty array to loyalty.csv
    CSV.open('./csv/loyalty.csv', "w") do |csv|
        loyalty.each do |item|
       csv << [item[:loyalty_number], item[:qty]]
       end
    # create a file called "todays date".csv and write sales hash to file
    # CSV.new('./csv/test.csv')
    CSV.open("./csv/#{date_today}.csv", "w") {|csv| sales_hash.to_a.each {|elem| csv << elem} }
   end
end

#open inventory.csv and save to array
CSV.open("./csv/inventory.csv") do |csv|
    csv.each do |line| 
        inventory.push({name: line[0], qty: line[1].to_i})
    end
end

#open loyalty.csv and save to array
CSV.open("./csv/loyalty.csv") do |csv|
    csv.each do |line|
        loyalty.push({loyalty_number: line[0], qty: line[1].to_i})
    end
end

welcome_font = TTY::Font.new(:doom)
pastel = Pastel.new


print "\e[8;150;150t"
puts "\e[H\e[2J"
puts pastel.yellow(welcome_font.write("Welcome to CoffeePOS!"))
puts "If you haven't done so already, please read the documentation on how to use this program".colorize(:light_green)
puts "Press enter to continue to the main menu".colorize(:light_green)
gets
user_exit = false

until user_exit
    puts "\e[H\e[2J"
    puts TTY::Box.frame(width: TTY::Screen.width, align: :center) { "1. New Order   2. Inventory   3. Loyalty Program   4. View Todays Sales   5. End of Day  \n\n\n\n Enter the number of the option you would like" }.colorize(:light_green)
    action = gets.chomp.downcase 
    if action == "1"
        inventory = coffeeOrder(inventory, loyalty, sales_hash, prices)
    elsif action == "2"
        inventory_exit = false
        puts "\e[H\e[2J"
        puts "--------------------------------------"
        puts "         Options"
        puts "1. Edit Inventory 2. Main Menu"
        puts "--------------------------------------"
        inventory.each do |line|
            puts "You have #{line[:qty]} units of #{line[:name]}"
        end
        
       
        input = gets.chomp
        if input == "1"
            editInventory(inventory)
        end
    elsif action == "3"
        puts "\e[H\e[2J"
        puts "Create or check loyalty number? check/create/main-menu"
        # response = gets.chomp
        response = gets.chomp
        if response == "check"
            puts "\e[H\e[2J"
            puts "Enter loyalty number"
            response = gets.chomp
            loyalty.each do |line|
                if response == line[:loyalty_number]
                    puts "\e[H\e[2J"
                    puts "Loyalty number found"
                    puts "#{5 - line[:qty]} more orders till next free coffee"
                    puts "Press enter to continue"
                    gets
                end
            end
        elsif response == "create"
            new_loyalty_number = false
            until new_loyalty_number
                random_num = Random.new()
                random_num = random_num.rand(10000).to_s
                if loyalty.find { |element| element[:loyalty_number] == random_num }
                    puts "Number is taken"
                else
                    loyalty.push({loyalty_number: random_num, qty: 0})
                    puts "\e[H\e[2J"
                    puts "New loyalty number created"
                    puts "Your number is #{random_num}"
                    new_loyalty_number = true
                end
            end
            puts "Press enter to continue"
            gets
        end
    

    elsif action == "4"
        puts "\e[H\e[2J"
        puts "Today you have sold #{sales_hash[:small]} small coffees, #{sales_hash[:medium]} medium coffees and #{sales_hash[:large]} large coffees!"
        puts "Press enter to return to menu"
        gets
        next
    elsif action == "5"
        dayEnd(inventory, loyalty, sales_hash)
        puts "\e[H\e[2J"
        puts "Exiting the program will save all changes to inventory, loyalty program and sales"
        puts "Are you sure you want to quit? yes/no"
        input = gets.chomp
            if input == "yes"
                puts "\e[H\e[2J"
                user_exit = true
            else
                next 
            end
    else
        puts "Please enter 1, 2, 3, 4 or 5"
        sleep 3
    end
end
