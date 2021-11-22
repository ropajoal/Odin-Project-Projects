require 'open-uri'
hangman = ["  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========",
        "  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========",
        "  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========",
        "  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========",
        "  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========",
        "  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========",
        "  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      |\n========="]
dic_file = URI.open('https://www.scrapmaker.com/data/wordlists/twelve-dicts/5desk.txt')
play_again = true
while play_again
  secret_word = ""
  until secret_word.length.between?(5,11)
    secret_word = dic_file.readlines.sample[0..-3]
    dic_file.rewind
  end
  array_secret = Array.new(secret_word.length,'_')

  errors = 0
  continue = true
  characters_played = []
  system "clear"
  puts array_secret.join(" ")
  puts hangman[0]

  while continue
    puts characters_played.join(", ")
    print "Select a character: "
    character = gets.chomp[0]
    characters_played.push(character)
    if secret_word.include?(character)
      secret_word.gsub(character).each { array_secret[Regexp.last_match.begin(0)] = character }
    else
      errors += 1
    end

    system "clear"
    puts array_secret.join(" ")
    puts hangman[errors]

    if array_secret.join == secret_word || errors == 6
      if array_secret.join == secret_word
        puts "YOU SURVIVED!!!"
      end
      if errors == 6
        puts "YOU ARE DEAD!!! The word was: #{secret_word}"
      end
      continue = false
      print "Would you like to play again?: "
      character = gets.chomp[0]
      play_again = false unless character == "y" || character == "Y"
    end
  end
end
