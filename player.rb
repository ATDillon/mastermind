# Handles human players input
class Player
  attr_reader :name

  private

  attr_reader :colors

  def initialize(name: 'Player', colors: %w[r b g y o p])
    @name = name
    @colors = colors
  end

  def player_choice
    gets.chomp.split('')
  end

  def input_check(size = 4)
    input = player_choice
    raise RuntimeError unless input.length == size
    raise TypeError unless input.all? { |item| colors.include?(item) }

    input
  rescue RuntimeError
    puts "Input size error! Make sure your guess has #{size} colors and try again:"
    retry
  rescue TypeError
    puts 'One or more colors input are invalid, please try again:'
    retry
  end

  public

  def color_code
    input_check
  end
end
