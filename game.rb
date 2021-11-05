require_relative 'computer'
require_relative 'player'

# Handles gameplay
class Game
  private

  attr_reader :player_one, :player_two, :colors
  attr_accessor :code

  def initialize(player_one:, player_two:, code: [], colors: %w[r b g y o p])
    @player_one = player_one
    @player_two = player_two
    @code = code
    @colors = colors
  end

  def code_input(player)
    player.color_code
  end

  def input_check(player, size = 4)
    input = code_input(player)
    raise unless input.length == size
    raise TypeError unless input.all? { |item| colors.include?(item) }

    input
  rescue RuntimeError
    puts "Input size error! Make sure your guess has #{size} colors and try again:"
    retry
  rescue TypeError
    puts 'One or more colors input are invalid, please try again:'
    retry
  end

  def matches(guess, char)
    code.each_with_index.reduce(0) do |total, (item, index)|
      total += 1 if item == char && item == guess[index]
      total
    end
  end

  def less_total?(guess, char, index)
    return true if guess[0..index].count(char) <= (code.count(char) - matches(guess, char))

    false
  end

  def char_same?(char, index)
    return true if char == code[index]

    false
  end

  def code_same?(guess)
    return true if guess == code
  end

  def code_checker(guess)
    guess.each_with_index.reduce([]) do |hint, (char, index)|
      if char_same?(char, index)
        hint.push('+')
      elsif less_total?(guess, char, index)
        hint.push('~')
      else
        hint.push('-')
      end
    end
  end

  public

  def play_game(first, second)
    self.code = input_check(first)

    12.times do
      guess = input_check(second)

      break print 'Victory' if code_same?(guess)

      print_hint(guess)
    end
  end

  def create_or_solve
    puts 'Enter 1 to solve the code or 2 to create it'
    input = gets.chomp

    raise unless %w[1 2].include?(input)

    play_game(player_two, player_one) if input == '1'
    play_game(player_one, player_two) if input == '2'

  rescue RuntimeError
    puts 'Invalid input, try again: '
    retry
  end 

  def print_hint(guess)
    puts code_checker(guess).join(' ')
  end
end

Game.new(player_one: Player.new, player_two: Computer.new).create_or_solve
