require_relative 'linkedlist'
class Bucket < LinkedList
  def initialize(pair)
    super()
    prepend(pair)
  end

  def map_to_array
    result = []
    each { |node| result.append(yield node) }
    result
  end

  def keys
    map_to_array { |node| node.value[0] }
  end

  def values
    map_to_array { |node| node.value[1] }
  end

  def entries
    map_to_array(&:value)
  end

  def includes?(key)
    !get_pair(key).nil?
  end

  def get_value(key)
    pair = get_pair(key)
    return pair.value[1] unless pair.nil?

    nil
  end

  def remove(key)
    index = find(key)
    return nil if index.nil?

    pair = at(index).value
    remove_at(index)
    pair[1]
  end

  def update(new_pair)
    pair_to_update = get_pair(new_pair[0])
    pair_to_update.value[1] = new_pair[1] unless pair_to_update.nil?
  end

  def get_pair(key)
    find_node { |node| node.value[0] == key }
  end
end
