# Computer player
class Computer
  attr_reader :name

  private

  attr_reader :colors
  attr_accessor :guess, :options

  def initialize(name: 'COM')
    @name = name
    @colors = %w[r b g y o p]
    @guess = []
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

  def color_picker
    options[Random.rand(options.length)]
  end

  public

  def color_code
    color_picker
  end
end
