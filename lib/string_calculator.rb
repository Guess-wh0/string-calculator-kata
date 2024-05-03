class StringCalculator
  def add(expression='')
    return 0 if expression.empty?
    expression.split(',').map(&:to_i).sum
  end
end
