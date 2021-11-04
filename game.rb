require_relative 'computer'
require_relative 'player'

# Handles gameplay
class Game
  private

  attr_reader :player_one, :player_two
  attr_accessor :code

  def initialize(player_one:, player_two:, code: ['r', 'b', 'y', 'o'])
    @player_one = player_one
    @player_two = player_two
    @code = code
  end

  def code_input(player)
    player.color_code
  end

  def same_amount?(guess, char, index)
    if (guess.count(char) == code.count(char)) || (guess[0..index].count(char) == code[0..index].count(char))
      return true
    end

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
      elsif same_amount?(guess, char, index)
        hint.push('~')
      else
        hint.push('-')
      end
    end
  end

  public

  def play_game
    self.code = code_input(player_two)

    12.times do
      guess = code_input(player_one)

      break print 'Victory' if code_same?(guess)

      print_hint(guess)
    end
  end

  def print_hint(guess)
    puts code_checker(guess).join(' ')
  end
end

Game.new(player_one: Player.new, player_two: Computer.new).play_game
