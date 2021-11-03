# Handles gameplay
class Game
  attr_reader :code

  def initialize(player_one:, player_two:, code: 'rbyg')
    @player_one = player_one
    @player_two = player_two
    @code = code
  end

  def code_same?(guess)
    return true if guess == code
  end

  def code_checker(guess); end
end
