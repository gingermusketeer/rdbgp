require_relative './byebug_interface'

inspector
puts 'starting'
num = 5
array = []
hash = {
  a: 2
}
def a
  puts 'a'
end

a

puts 'ending'
