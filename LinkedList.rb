class LinkedList
  @head = nil
  @tail = nil

  class Node
    attr_accessor :value, :next_node
    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node 
    end
    def to_s
      @value.to_s
    end
  end

  def append(value)
    if @tail == nil
      @tail = Node.new(value)
      @head = @tail
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  def prepend(value)
    if @head == nil
      @tail = Node.new(value)
      @head = @tail
    else
      @head = Node.new(value, @head)
    end
  end

  def size
    current = @head
    counter = 0
    until current == nil
      counter += 1
      current = current.next_node
    end
    counter
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def at(index)
    current = @head
    counter = 0
    until current == nil
      return current if counter == index
      current = current.next_node
      counter += 1
    end
  end

  def pop
    current = @head
    last_node = @tail
    until current.next_node == @tail
      current = current.next_node 
    end
    @tail = current
    @tail.next_node = nil
    last_node
  end

  def contains?(value)
    current = @head
    until current == nil
      current = current.next_node
      return true if current.value == value
    end
    return false
  end

  def find(value)
    current = @head
    counter = 0
    until current == nil
      current = current.next_node
      return counter if current.value == value
      counter += 1
    end
    return nil
  end

  def to_s
    current = @head
    puts current.value
    link_string = "( #{current} )"
    until current == nil
      link_string += " -> ( #{current.next_node} )"
      current = current.next_node
    end
    link_string
  end

  def insert_at(value, index)
    if index == 0
      @head = Node.new(value,@head)
    else
      prev = @head
      current = prev.next_node
      counter = 1
      until current.next_node == nil || counter == index
        prev = current
        current = current.next_node
        counter += 1
      end
      prev.next_node = Node.new(value, current)
    end
  end

  def remove_at(index)
    if index == 0
      @head = @head.next_node
    else
      prev = @head
      current = prev.next_node
      counter = 1
      until current.next_node == nil || counter == index
        prev = current
        current = current.next_node
        counter += 1
      end
      prev.next_node = current.next_node
    end
  end
end
