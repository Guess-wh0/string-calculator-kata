class StringCalculator
  INVALID_FORMATS = [/,[\n]*\z/, /,\n*,/, /[^0-9\n,]/].freeze

  private def valid?(expression= '')
    INVALID_FORMATS.none? { |exp| exp.match?(expression) }
  end

  def add(expression='')
    # clean expression from empty spaces
    expression.gsub!(' ', '')
    return 0 if expression.empty?

    unless valid?(expression)
      raise ArgumentError, 'Invalid format'
    end
    expression.split(/[,\n]/).map(&:to_i).sum
  end
end
