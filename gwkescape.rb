puts """
\nYou wake up to the sound of your alarm going off.  Damn! You're late for work!
But wait! You have to grab a few things before you can dash out the door.

In order to leave you need your Wallet, Glasses, Keys and Phone.

You just woke up, so you're currently in your bedroom.
You'll need to collect all four items before you can leave.

Here is the layout of your house.
__________________
|       Bedroom  |
|  H  |----------|
|  A    Bathroom |
|  L  |----------|
|  L    Kitchen  |
|     |----------|
|       Rumpus   |
|EXIT -----------|

Mash the keypad to start your day.

"""

start = gets.chomp
counter = 100
#Hash
#rooms = {1 => "bedroom", 2 => "bathroom", 3 => "kitchen", 4 => "rumpus", 5 => "hall", 0 => "exit"}
#item_location = {1 => "nightstand", 2 => "dresser", 3 => "shower", 4 => "toilet", 5 => "counter", 6 => "fridge", 7 => "lazy boy", 0 => "pool table"}

#Arrays
array_rooms = ["bedroom", "bathroom", "kitchen", "rumpus", "hall", "exit"]
array_item_location = ["nightstand", "dresser", "shower", "toilet", "counter", "fridge", "lazy boy", "pool table"]

#Room locations
bed_location = ["nightstand", "dresser"]
bath_location = ["shower", "toilet"]
kitchen_location = ["counter", "fridge"]
rumpus_location = ["lazy boy", "pool table"]

room_hash = {"bedroom" => bed_location, "bathroom" => bath_location, "kitchen" => kitchen_location, "rumpus" => rumpus_location, "hall" => [], "exit" => []}

#Items
items = ["wallet", "glasses", "keys", "phone"]
inventory = []
current_location = "bedroom"

#Item Locations
item_hash = {}
item_locations = []
wallet_location = array_item_location.sample(1)
array_item_location -= wallet_location
item_locations += wallet_location
item_hash[:"#{wallet_location}"] = "wallet"

glasses_location = array_item_location.sample(1)
array_item_location -= glasses_location
item_locations += glasses_location
item_hash[:"#{glasses_location}"] = "glasses"

keys_location = array_item_location.sample(1)
array_item_location -= keys_location
item_locations += keys_location
item_hash[:"#{keys_location}"] = "keys"

phone_location = array_item_location.sample(1)
array_item_location -= phone_location
item_locations += phone_location
item_hash[:"#{phone_location}"] = "phone"
puts item_hash



response = ""
until response == "quit"
  until inventory.length == 4 && current_location == "exit"
    case current_location
    when "hall"
      puts "\nYou're back in the hall.
      Here is the layout of your house.
      __________________
      |       Bedroom  |
      |  H  |----------|
      |  A    Bathroom |
      |  L  |----------|
      |  L    Kitchen  |
      |     |----------|
      |       Rumpus   |
      |EXIT -----------|

      Where do you want to go?
        "
        current_location = gets.chomp
      when "exit"
        puts "you can't leave yet.  You don't have all your stuff!"
        current_location = "hall"
      else
        puts "\nYou are in your #{current_location}. There are a #{room_hash[current_location].join(" and a ")} in front of you."
        puts "\nDo you want to check the #{room_hash[current_location][0]} or the #{room_hash[current_location][1]} or go out to the hall?"

        searching = gets.chomp.downcase
        case searching
        when "hall"
          current_location = "hall"
        when "#{room_hash[current_location][0]}"
          if item_locations.include? "#{room_hash[current_location][0]}"
            puts "#{room_hash[current_location][0]}"
            puts "#{item_hash["#{room_hash[current_location][0]}"]}"
            puts "You found your #{item_hash["#{room_hash[current_location][0]}"]}"
          end
        when "#{room_hash[current_location][1]}"
          if item_locations.include? "#{room_hash[current_location][1]}"
            puts "#{room_hash[current_location][1]}"
            puts "#{item_hash["#{room_hash[current_location][1]}"]}"
            puts "You found your #{item_hash["#{room_hash[current_location][1]}"]}"
          end
        end
      end
  end
  puts "Congratulations, you're out the door!"
end
