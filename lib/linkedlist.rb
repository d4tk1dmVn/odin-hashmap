require_relative 'node'

class LinkedList
  attr_accessor :head, :tail
  attr_reader :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def empty?
    @size.zero?
  end

  def each
    nomad = @head
    until nomad.nil?
      yield nomad
      nomad = nomad.next_node
    end
  end

  def find_node
    nomad = @head
    until nomad.nil?
      return nomad if yield nomad

      nomad = nomad.next_node
    end
    nil
  end

  def at(index)
    index = sanitize_index(index)
    nomad = @head
    index.times { nomad = nomad.next_node }
    nomad
  end

  def find(value)
    index = 0
    each do |node|
      return index if node.value == value

      index += 1
    end
    nil
  end

  def contains?(value)
    !find(value).nil?
  end

  def to_s
    result = ''
    each { |node| result += "( #{node.value} -> " }
    "#{result}nil"
  end

  def to_a
    result = []
    each { |node| result.append(node.value) }
    result
  end

  def append(value)
    new_node = Node.new(value)
    @head = new_node if empty?
    @tail.next_node = new_node unless empty?
    @tail = new_node
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)
    if empty?
      @head = @tail = new_node
    else
      new_node.next_node = @head
      @head = new_node
    end
    @size += 1
  end

  def pop
    raise 'ERROR: POP FROM EMPTY LIST NOT ALLOWED' if empty?

    result = @tail
    if @head == @tail
      @head = @tail = nil
    else
      @tail = at(@size - 2)
      @tail.next_node = nil
    end
    @size -= 1
    result
  end

  def insert_at(index, value)
    index = sanitize_index(index)
    if empty? || index.zero?
      prepend(key, value)
    elsif index == @size
      append(key, value)
    else
      previous_node = at(index - 1)
      new_node = Node.new(value, previous_node.next_node)
      previous_node.next_node = new_node
      @size += 1
    end
  end

  def remove_at(index)
    raise 'ERROR: EMPTY LIST' if empty?

    index = sanitize_index(index)
    if index.zero?
      remove_head
    elsif index == @size - 1
      pop
    else
      previous_node = at(index - 1)
      previous_node.next_node = previous_node.next_node.next_node
      @size -= 1
    end
  end

  private

  def sanitize_index(index)
    index += @size if index.negative?
    raise 'ERROR: INVALID INDEX' if index.negative? || index > @size - 1

    index
  end

  def remove_head
    @size -= 1
    @head = @head.next_node
    @tail = @head if @size < 2
  end
end
