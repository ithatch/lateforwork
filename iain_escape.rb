# Creates Class "Room" for which objects will be initialized with a name, and a blank
# array "locations" as well as a method ".name", ".locations" and ".add_locations"
class Room
  attr_reader :name, :locations

  def initialize(name)
    @name = name
    @locations = []
  end

  def add_location(location)
    @locations.push(location)
  end
end

# Creates Class "Location" for which objects will be initialized with a name, and a method ".name"
# a method .item, and a setter "item = " to assign items to locations.
class Location
  attr_reader :name
  attr_accessor :item

  def initialize(name)
    @name = name
  end
end

# Creates Class "Item" for which objects will be initialized with a name, and a method ".name"
class Item
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

room_names = [
  "bedroom",
  "bathroom",
  "kitchen",
  "rumpus",
  "hall",
  "exit"
]

location_names = [
  "nightstand",
  "dresser",
  "shower",
  "toilet",
  "counter",
  "fridge",
  "lazy boy",
  "pool table"
]

greetings = [
  "Avast matey!",
  "Look man",
  "Okay boss",
  "In THIS reality",
  "So",
  "Look",
  "Listen chief",
  "Pay attention,",
  "This one time I was almost stabbed by a rebelious, knife-wielding octopus.  But anyway,",
]

item_names = %w(wallet glasses keys phone)

# Initializes items objects
items = item_names.map do |item_name|
  Item.new(item_name)
end

# Initializes locations objects
locations = location_names.map do |location_name|
  Location.new(location_name)
end

# Initializes rooms objects
rooms = room_names.map do |room_name|
  Room.new(room_name)
end

# Associates rooms with locations
room_hash = {
   "bedroom" => ["nightstand", "dresser"],
   "bathroom" => ["shower", "toilet"],
   "kitchen" => ["counter", "fridge"],
   "rumpus" => ["lazy boy", "pool table"],
   "hall" => [],
   "exit" => []
 }

# Assign locations to each room
rooms.each do |room|
  room_hash[room.name].each do |location|
    room.add_location(location)
  end
end

# Assign items to locations, without repeating
items.each do |item|
  location = locations.sample
  if location.item
    redo
  end
  location.item = item
end

timer = 15
inventory = []
prompt = "> "
current_room_name = "bedroom"

# locations.each do |location|
#   puts "the #{location.item.name} is in the #{location.name}" if location.item
# end

#quit = abort

puts """
-- BEEP! BEEP! BEEP! --


You wake up to the sound of your alarm going off.  Damn! You're late for work!


But wait! You have to grab a few things before you can dash out the door.

In order to leave you need your:
- Wallet
- Glasses
- Keys
- Phone.

Once you've collected all four, go back to the hall, and you're out the door!



Type your name, and press ENTER to start.

"""

my_name = gets.chomp
response = ""
until inventory.length == 4 && current_room_name == "exit"
  if inventory.length ==4
    puts "
-- Almost There --

You've found all your stuff! head back to the hall, and out the door!
    "
  end
  if timer == 0
    abort("

-- OUT OF TIME! --

You ran out of time!

    ")
  end
  case current_room_name
  when "quit"
    abort("""

    You've given up and gone back to bed.

    """)
  when "hall"
    puts """
     -----     HALL     -----

You're back in the hall. Here is the layout of your house.
__________________
|       Bedroom  |
|  H  |----------|
|  A    Bathroom |
|  L  |----------|
|  L    Kitchen  |
|     |----------|
|       Rumpus   |
|EXIT -----------|

You have #{timer} minutes left, where do you want to go?

"

    prompt = "> "
    current_room_name = gets.chomp.downcase;
    case current_room_name
    when "hall"
      current_room_name = "hall"
    else
      timer -= 1
    end

    when "exit"
      puts "you can't leave yet.  You don't have all your stuff!"
      current_room_name = "hall"
    else
      if room_names.include? "#{current_room_name}"

        puts """
-- #{current_room_name.upcase} --
\n#{greetings.sample} you see a #{room_hash[current_room_name].join(" and a ")} in front of you.
\nDo you want to investigate the #{room_hash[current_room_name][0]}, the #{room_hash[current_room_name][1]} or go back to the hall?\n
      """
        puts "You have #{timer} minutes left.  Which location do you want to check out #{my_name}?"

        print prompt

        searching = gets.chomp.downcase

        if searching == "hall"
          current_room_name = "hall"
          timer -= 1
          next
        end

        if searching == "quit"
          abort("\n-- QUIT --\n The struggle is too real! You've given up and gone back to bed.
          ")
        end

  # defines variable location as equal to one of the values in "locations"
        location = locations.find { |location| location.name == searching}

        unless location
          puts "\nI didn't understand that, please try again.
          "
          redo
        end


        unless location && location.item
          puts "\nLooks like you didn't find anything there.
          "
          timer -= 1
        end

  # Adds item to inventory unless it's already in the inventory
        if location && location.item
          if inventory.include?(location.item)
            puts "
            You already searched here.  You found your #{location.item.name} remember?!
            "
            timer -= 1
          else
            inventory << location.item
            timer -= 1
            puts "\nYou found your #{location.item.name}!"
            puts "Your inventory:"
            inventory.each do |item|
              puts "- #{item.name}"
            end
          end
        end
      else
      puts "\n-- OOPS! --\n
Sorry, didn't understand that, Try again.\n
      "
      current_room_name = "hall"
      timer += 1
      end
    end
  end
  puts "

  -- WINNER --

  You did it! You're out the door and you just might make it to work on time!
  "
