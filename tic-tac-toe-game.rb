class TicTacToeGame
  @board = Array.new(9," ")
  def self.start
    print "Enter X player name: "
    name_x = gets.chomp
    player_x = Player.new(name_x,"X")
    print "Enter O player name: "
    name_y = gets.chomp
    player_o = Player.new(name_x,"O")
    continue = true
    turns = 1 
    show_board
    while continue
      current_player = current_player == player_x ? player_o : player_x
      current_player.play
      show_board
      if check_winner?(current_player.character)
        puts "The Winner is: #{current_player.name}"
        continue = false
      end
      if turns < 9
        turns += 1
      else
        puts "It's a Draw!!!"
        continue = false
      end
    end
  end
  def self.set_play(num,character)
    raise "Position already entered" unless @board[num] == " "
    @board[num] = character 
  end
  def self.show_board
    system "clear"
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "---+---+---"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "---+---+---"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
  end
  def self.check_winner?(character)
    (@board.select.with_index{|val,index| index.between?(0,2)}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index.between?(3,5)}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index.between?(6,8)}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index % 3 == 0}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index % 3 == 1}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index % 3 == 2}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index % 4 == 0}).all?{ |item| item ==character }\
    || (@board.select.with_index{|val,index| index.even? && index!=0 && index!=(@board.length-1) }).all?{ |item| item ==character }
  end
end

class Player 
  attr_reader :name, :character
  def initialize(name,character)
    @name = name
    @character = character
  end
  def play
    begin
      print "Select region to put #{@character}(1-9): "
      num = (gets.match(/\d/)[0]).to_i - 1
      TicTacToeGame.set_play(num,@character)
    rescue StandardError=>e
      puts "Erroneous input!"
      puts e
      puts "\t Try again...\n"
      retry
    end
  end
end

TicTacToeGame.start
