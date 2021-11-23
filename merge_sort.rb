def merge_sort(array)
  def mergeSortedArrays (array1,array2)
    n1, n2 = array1.length, array2.length
    merged = []
    i = 0
    j = 0
    until merged.length == n1 + n2
      if(array1[i]<array2[j])
        merged << array1[i]
        i += 1
        array2[j..n2].each { |item| merged << item } if i==n1
      else
        merged << array2[j]
        j += 1
        array1[i..n1].each { |item| merged << item } if j==n2
      end
    end
    return merged    
  end
  n = array.length
  return array if n == 1
  splitted_array = array.each_slice(n/2).to_a
  array1 = splitted_array[0]
  array2 = splitted_array[1]
  array2 << splitted_array[2][0] if splitted_array[2] 
  mergeSortedArrays(merge_sort(array1),merge_sort(array2))
end
p merge_sort([40,50,80,20,32,84,102,100,32,10,15,5,99,25,29])
