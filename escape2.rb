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

Type your name to start your day.

"""
prompt = "> "
print prompt
start = gets.chomp
puts "Hi #{start}!"
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
array_item_location.shuffle!
items.each do |item|
  item_hash[item.to_sym] = array_item_location.pop
end

item_locations = item_hash.invert

puts item_hash
puts item_hash.invert

response = ""
until inventory.length == 4 && current_location == "exit"
  case current_location
  when "hall"
    puts """
-------------------------------------------------------------------------------
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

Where do you want to go?
-------------------------------------------------------------------------------
"

      current_location = gets.chomp.downcase
    when "exit"
      puts "you can't leave yet.  You don't have all your stuff!"
      current_location = "hall"
    else
      puts "\nYou are in your #{current_location}. There are a #{room_hash[current_location].join(" and a ")} in front of you."
      puts "\nDo you want to check the #{room_hash[current_location][0]} or the #{room_hash[current_location][1]} or go out to the hall?"
      puts prompt

      searching = gets.chomp.downcase
      case searching
      when "hall"
        current_location = "hall"
      when "#{room_hash[current_location][0]}"
        if !item_locations[room_hash[current_location][0]].nil?
          puts "#{room_hash[current_location][0]}"
          puts "#{item_hash["#{room_hash[current_location][0]}"]}"
          puts "You found your #{item_hash["#{room_hash[current_location][0]}"]}"
        end
      when "#{room_hash[current_location][1]}"
        if !item_locations[room_hash[current_location][1]].nil?
          puts "#{room_hash[current_location][1]}"
          puts "#{item_hash["#{room_hash[current_location][1]}"]}"
          puts "You found your #{item_hash["#{room_hash[current_location][1]}"]}"
        end
      when "quit"
        abort("\nYou've given up and gone back to bed.")
      end
      end
end
puts "Congratulations, you're out the door!"
