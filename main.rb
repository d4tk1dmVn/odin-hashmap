require_relative 'lib/hashmap'

pairs = [['apple', 'red'], ['banana', 'yellow'], ['carrot', 'orange'], ['dog', 'brown'], ['elephant', 'gray'], ['frog', 'green'], ['grape', 'purple'], ['hat', 'black'], ['icecream', 'white'], ['jacket', 'blue'], ['kite', 'pink'], ['lion', 'golden']]

overwrite_pairs = [['apple', 'burlete'], ['banana', 'burlete'], ['dog', 'papageno'], ['elephant', 'yellow'], ['kite', 'foo'], ['lion', 'bar']]


carambolas_pairs = [['apple', 'carambolas'], ['banana', 'carambolas'], ['carrot', 'carambolas'], ['dog', 'carambolas'], ['elephant', 'carambolas'], ['frog', 'carambolas'], ['grape', 'carambolas'], ['hat', 'carambolas'], ['icecream', 'carambolas'], ['jacket', 'carambolas'], ['kite', 'carambolas'], ['lion', 'carambolas']]

test = HashMap.new
pairs.each { |pair| test.set(*pair) }
puts "The hash length is #{test.length} and it should be #{pairs.length}"
test.show_buckets
puts "***************************************************************************"
overwrite_pairs.each { |pair| test.set(*pair) }
puts "The hash length is #{test.length}"
test.show_buckets
puts "***************************************************************************"
test.set('moon', 'silver')
puts "The hash length is #{test.length}"
test.show_buckets
puts "***************************************************************************"
carambolas_pairs.each { |pair| test.set(*pair) }
puts "The hash length is #{test.length}"
test.show_buckets
puts "***************************************************************************"
