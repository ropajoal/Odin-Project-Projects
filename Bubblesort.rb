def bubble_sort(array)
  count = array.length - 2
  count.downto(1) do |i|
    0.upto(i) do |j|
      if array[j]>array[j+1]
        tmp = array[j]
        array[j] = array[j+1]
        array[j+1] = tmp
      end
    end
  end
  array
end