# Handles human players input
class Player
  attr_reader :name

  private

  def initialize(name: 'Player')
    @name = name
  end

  def player_choice
    gets.chomp
  end

  public

  def color_code
    player_choice.split('')
  end
end
