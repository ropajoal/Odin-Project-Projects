def caesar_cipher(string,shift)
  shift = shift.remainder(26)
  caesar_array = string.chars.map do |letter|
    letter_num = letter.ord
    case letter_num
    when 65..90
      cipher_num = letter_num + shift
      cipher_num += cipher_num > 90 ? -26 :
      cipher_num < 65 ? 26 :
      0
      cipher_num.chr
    when 67..122
      cipher_num = letter_num + shift
      cipher_num += cipher_num > 122 ? -26 :
      cipher_num < 97 ? 26 :
      0
      cipher_num.chr
    else
      letter
    end
  end
  caesar_array.join
end