# Computer player
class Computer
  attr_reader :name

  private

  attr_reader :colors

  def initialize(name: 'COM')
    @name = name
    @colors = %w[r b g y o p]
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
