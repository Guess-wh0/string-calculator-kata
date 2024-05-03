class StringCalculator
  INVALID_FORMATS = [/,[\n]*\z/, /,\n*,/].freeze
  attr_accessor :expression, :delimiter

  private def valid?
    char_format = /[^0-9#{delimiter}\n]/
    (INVALID_FORMATS + [char_format]).none? { |exp| exp.match?(expression) }
  end

  def add(exp='')
    @expression = exp
    @delimiter = ','
    return 0 if expression.empty?

    if expression.start_with?('//')
      @delimiter = expression[2]
      @expression = expression.split("\n", 2)[1]
    end

    @expression.gsub!(' ', '') unless delimiter.match?(/\s/)
    raise ArgumentError, 'Invalid format' unless valid?

    expression.split(/[#{delimiter}\n]/).map(&:to_i).sum
  end
end
