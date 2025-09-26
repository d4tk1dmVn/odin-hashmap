require_relative 'bucket'

class HashMap
  attr_reader :load_factor, :capacity

  def initialize(load_factor = 0.75, capacity = 17)
    @load_factor = load_factor
    @original_capacity = capacity
    @capacity = capacity
    @buckets = Array.new(capacity)
  end

  def hash(key)
    ord_code_sum = key.chars.map(&:ord).sum
    fraction = (Math.sqrt(5) - 1) / 2
    (@capacity * ((ord_code_sum * fraction) % 1)).floor
  end

  def set(key, value)
    hashed_key = hash(key)
    indexed_bucket = @buckets[hashed_key]
    if !indexed_bucket.nil? && indexed_bucket.includes?(key)
      indexed_bucket.update([key, value])
      return
    end
    duplicate_size if load_factor_reached?
    if @buckets[hashed_key].nil?
      @buckets[hashed_key] = Bucket.new([key, value])
    else
      @buckets[hashed_key].prepend([key, value])
    end
  end

  def get(key)
    hashed_key = hash(key)
    return nil if @buckets[hashed_key].nil?

    @buckets[hashed_key].get_value(key)
  end

  def has?(key)
    hashed_key = hash(key)
    return false if @buckets[hashed_key].nil?

    @buckets[hashed_key].includes?(key)
  end

  def remove(key)
    hashed_key = hash(key)
    return nil if @buckets[hashed_key].nil?

    @buckets[hashed_key].remove(key)
  end

  def length
    @buckets.reduce(0) { |sum, bucket| sum + (bucket&.size || 0) }
  end

  def clear
    @buckets = Array.new(capacity)
  end

  def keys
    @buckets.reduce([]) { |result, bucket| result + (bucket&.keys || []) }
  end

  def values
    @buckets.reduce([]) { |result, bucket| result + (bucket&.values || []) }
  end

  def entries
    @buckets.reduce([]) { |result, bucket| result + (bucket&.entries || []) }
  end

  def current_load
    length.to_f / @capacity
  end

  def show_buckets
    @buckets.each do |bucket|
      representation = bucket.nil? ? [] : bucket.entries
      print "#{representation}\n"
    end
  end

  private

  def duplicate_size
    copy = entries
    clear
    @capacity += @capacity
    copy.each { |pair| set(*pair) }
  end

  def load_factor_reached?
    (length + 1).to_f / @capacity >= @load_factor
  end
end
