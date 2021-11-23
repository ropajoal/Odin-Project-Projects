class Array
  def my_each
    self.length.times { |i| yield self[i] }
  end
  def my_each_with_index
    self.length.times { |i| yield self[i], i }
  end
  def my_select
    selected_array = []
    self.my_each{ |item| selected_array.push(item) if yield item }
    selected_array
  end
  def my_all?
    self.my_each{ |item| return false unless yield item }
    return true
  end
  def my_any?
    self.my_each { |item| return true if yield item }
    return false
  end
  def my_none?
    self.my_each { |item| return false if yield item }
    return true
  end
  def my_count
    count = 0
    self.my_each { |item| count += 1 if yield item }
    count
  end
  def my_map (&block)
    map_array = []
    self.my_each{ |item| map_array << block.call(item) }
    map_array
  end
  def my_inject 
    result = self[0]
    self[1..-1].my_each{ |item| result = yield result, item } 
   result
  end
end

def multiply_els(array)
  array.my_inject { |result, item| result * item }
end
