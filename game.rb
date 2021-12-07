require_relative 'computer'
require_relative 'player'

# Handles gameplay
class Game
  private

  attr_reader :player_one, :player_two, :feedback
  attr_accessor :code, :hint

  def initialize(player_one:, player_two:, feedback: { right: '+', misplaced: '~', wrong: '-' })
    @player_one = player_one
    @player_two = player_two
    @code = []
    @hint = []
    @feedback = feedback
  end

  def code_input(player, hint)
    player.color_code(hint)
  rescue ArgumentError
    player.color_code
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
        hint.push(feedback[:right])
      elsif less_total?(guess, char, index)
        hint.push(feedback[:misplaced])
      else
        hint.push(feedback[:wrong])
      end
    end
  end

  def create_hint(guess)
    self.hint = code_checker(guess)
  end

  def gameplay(first, second)
    self.code = code_input(first, hint)

    12.times do
      guess = code_input(second, hint)
      create_hint(guess)

      break puts "#{second.name} Victory" if code_same?(guess)

      print_hint
      puts guess.join(' ')
    end
  end

  def create_or_solve
    puts 'Enter 1 to solve the code or 2 to create it'
    input = gets.chomp

    raise unless %w[1 2].include?(input)

    gameplay(player_two, player_one) if input == '1'
    gameplay(player_one, player_two) if input == '2'
  rescue RuntimeError
    puts 'Invalid input, try again: '
    retry
  end

  def print_hint
    puts hint.join(' ')
  end

  public

  def play_game
    create_or_solve
  end
end

Game.new(player_one: Player.new, player_two: Computer.new).play_game
