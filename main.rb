require_relative 'lib/hashmap'

pairs = [['apple', 'red'], ['banana', 'yellow'], ['carrot', 'orange'], ['dog', 'brown'], ['elephant', 'gray'], ['frog', 'green'], ['grape', 'purple'], ['hat', 'black'], ['icecream', 'white'], ['jacket', 'blue'], ['kite', 'pink'], ['lion', 'golden']]

overwrite_pairs = [['apple', 'burlete'], ['banana', 'burlete'], ['dog', 'papageno'], ['elephant', 'yellow'], ['kite', 'foo'], ['lion', 'bar']]


carambolas_pairs = [['apple', 'carambolas'], ['banana', 'carambolas'], ['carrot', 'carambolas'], ['dog', 'carambolas'], ['elephant', 'carambolas'], ['frog', 'carambolas'], ['grape', 'carambolas'], ['hat', 'carambolas'], ['icecream', 'carambolas'], ['jacket', 'carambolas'], ['kite', 'carambolas'], ['lion', 'carambolas']]

test = HashMap.new
pairs.each { |pair| test.set(*pair) }
overwrite_pairs.each { |pair| test.set(*pair) }
test.set('moon', 'silver')
carambolas_pairs.each { |pair| test.set(*pair) }
