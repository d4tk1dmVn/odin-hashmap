require_relative 'linkedlist'
class HashSet
  def initialize(load_factor = 0.75, capacity = 17)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity)
  end

  def empty?
    length.zero?
  end

  def length
    @buckets.reduce(0) { |sum, bucket| sum + (bucket&.size || 0) }
  end

  def clear
    @buckets = Array.new(@capacity)
  end

  def add(element)
    hashed_element = hash(element)
    indexed_bucket = @buckets[hashed_element]
    return if !indexed_bucket.nil? && indexed_bucket.contains?(element)

    duplicate_size if load_factor_reached?
    hashed_element = hash(element)
    @buckets[hashed_element] = LinkedList.new if @buckets[hashed_element].nil?
    @buckets[hashed_element].prepend(element)
  end

  def get(elem)
    hashed_elem = hash(elem)
    return nil if @buckets[hashed_elem].nil?

    @buckets[hashed_elem].find_node { |node| node.value == elem }
  end

  def has?(elem)
    hashed_elem = hash(elem)
    return false if @buckets[hashed_elem].nil?

    @buckets[hashed_elem].contains?(elem)
  end

  def remove(elem)
    bucket = @buckets[hash(elem)]
    return false if bucket.nil? || bucket.find(elem).nil?

    bucket.remove_at(bucket.find(elem))
    true
  end

  def values
    @buckets.reduce([]) do |result, bucket|
      result + (bucket.nil? ? [] : bucket.to_a)
    end
  end

  private

  def hash(key)
    ord_code_sum = key.to_s.chars.map(&:ord).sum
    fraction = (Math.sqrt(5) - 1) / 2
    (@capacity * ((ord_code_sum * fraction) % 1)).floor
  end

  def duplicate_size
    copy = values
    clear
    @capacity += @capacity
    copy.each { |elem| add(elem) }
  end

  def load_factor_reached?
    (length + 1).to_f / @capacity >= @load_factor
  end
end
