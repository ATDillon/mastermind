# Computer player
class Computer
  attr_reader :name

  private

  attr_reader :colors

  def initialize(name: 'COM')
    @name = name
    @colors = %w[r b g y o p]
  end

  def combos(count)
    result = colors
    (count - 1).times do
      result = options.reduce([]) do |a, color|
        a + result.map { |next_color| [color] + [next_color] }.each(&:flatten!)
      end
    end
    result
  end

  def color_picker
    colors[Random.rand(colors.length)]
  end

  public

  def color_code(count = 4)
    code = []
    count.times do
      code.push(color_picker)
    end
    code
  end
end
