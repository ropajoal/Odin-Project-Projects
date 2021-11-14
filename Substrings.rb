def substrings(string,dictionary)
  dictionary.reduce(Hash.new(0)) do |result, word|
    ocurrences = string.scan(word).length
    result[word] = ocurrences unless ocurrences == 0
    result
  end
end