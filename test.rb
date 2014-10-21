require_relative './byebug_interface'

inspector
puts 'starting'

def a
  puts 'a'
end

a

puts 'ending'
