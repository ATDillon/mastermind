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

  def any_wrong(hint)
    return if hint.any? { |char| char == feedback[:wrong] }

    options.select { |array| array.all? { |item| guess.include?(item) } }
  end

  def bad_spot(hint)
    result = options
    hint.each_with_index do |item, index|
      next unless item == feedback[:misplaced]

      result.reject! { |array| array[index] == guess[index] }
      result.select! { |array| character_count(array, guess[index]) >= character_count(hint, item) }
    end
    result
  end

  def character_count(array, character)
    count = 0
    array.each do |color|
      count += 1 if color == character
    end
    count
  end

  def correct(hint)
    result = options
    hint.each_with_index do |item, index|
      next unless item == feedback[:right]

      result.select! { |array| array[index] == guess[index] }
    end
    result
  end

  def option_remover(hint); end

  def option_picker
    self.guess = options[Random.rand(options.length)]
    guess
  end

  public

  def color_code
    option_picker
  end
end
