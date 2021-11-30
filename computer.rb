# Computer player
class Computer
  attr_reader :name

  private

  attr_reader :colors, :feedback
  attr_accessor :guess, :options

  def initialize(name: 'COM', feedback: {right: '+', misplaced: '~', wrong: '-'})
    @name = name
    @colors = %w[r b g y o p]
    @guess = []
    @feedback = feedback
    @options = combos(4)
  end

  def combos(count)
    result = colors
    (count - 1).times do
      result = colors.reduce([]) do |a, color|
        a + result.map { |next_color| [color] + [next_color] }.each(&:flatten!)
      end
    end
    result
  end

  def any_wrong(hint); end

  def bad_spot(hint); end

  def correct(hint); end

  def option_remover(hint); end

  def option_picker
    options[Random.rand(options.length)]
  end

  public

  def color_code
    option_picker
  end
end
