require 'continued_fractions/include'

# ContinuedFraction
#
# Generates quotients and convergents for a given number
#
# @author Jose Hales-Garcia
#
# @attr_reader number [Numeric]
#   The number who's continued fraction is being calculated
# @attr_reader quotients [Array]
#   The array of quotients of the continued fraction
# @attr_reader convergents [Array]
#   The convergents of the continued fraction
# @attr_reader limit [Integer]
#   The limit to calculate. Practical for real numbers, although they're limited by the system.
#
class ContinuedFraction
  include Comparable

  attr_reader :number, :quotients, :convergents, :limit

  DEFAULT_LIMIT = 5

  # @return [ContinuedFraction] the quotients and convergents of a continued fraction for a given number.
  # @example
  #   ContinuedFraction.new(Math::PI,10)
  #   => 3.141592653589793, quotients: [3, 7, 15, 1, 292, 1, 1, 1, 2, 1], convergents: [(3/1), (22/7), (333/106), (355/113), (103993/33102), (104348/33215), (208341/66317), (312689/99532), (833719/265381), (1146408/364913)]
  # @param number [Numeric]
  # @param limit [Integer]
  #
  def initialize(number, limit=DEFAULT_LIMIT)
    @number = number
    @ratioed_number = number.to_r
    @quotients, @convergents, @limit = calculate_quotients_and_convergents(limit)
  end

  # @return [ContinuedFraction] the CF sum of self and another CF
  # @param other [ContinuedFraction]
  #
  def +(other)
    number_of(other) do |num,prec|
      evaluate("#{number} + #{num}",prec)
    end
  end

  # @return [ContinuedFraction] the CF difference of self and another CF
  # @param other [ContinuedFraction]
  #
  def -(other)
    number_of(other) do |num,prec|
      evaluate("#{number} - #{num}",prec)
    end
  end

  # @return [ContinuedFraction] the CF quotient of self and another CF
  # @param other [ContinuedFraction]
  #
  def /(other)
    number_of(other) do |num,prec|
      evaluate("#{number} / #{num}",prec)
    end
  end

  # @return [ContinuedFraction] the CF product of self and another CF
  # @param other [ContinuedFraction]
  #
  def *(other)
    number_of(other) do |num,prec|
      evaluate("#{number} * #{num}",prec)
    end
  end

  def <=>(other)
    number <=> other.number
  end

  def inspect
    "#{number}, quotients: #{quotients}, convergents: #{convergents[0..-1]}"
  end

  private
  def evaluate(exp, prec) #:nodoc:
    ContinuedFraction.new(eval(exp), prec)
  end

  def number_of(n) #:nodoc:
    num = nil
    prec = nil
    case n
    when Float, Integer, Rational
      num = n
      prec = limit
    when ContinuedFraction
      num = n.number
      prec = [n.limit,limit].max
    end
    yield(num,prec)
  end

  def calculate_quotients_and_convergents(limit)
    x = @number

    _quotients = []
    _convergents = [] #Convergents.new

    # Initialize the initial values for p and q
    p_minus_1, q_minus_1 = 0, 1
    p_0, q_0 = 1, 0

    q = x.to_i

    # Loop for maximum specified terms or until the fractional part becomes zero
    limit.times do
      _quotients << q

      # Calculate the new p and q
      p_n = q * p_0 + p_minus_1
      q_n = q * q_0 + q_minus_1

      convergent = Rational(p_n, q_n)
      _convergents << convergent

      break if ((@number - convergent).to_f).zero?

      x_rem = x - q
      break if x_rem.zero?

      # Recalculate the fractional part
      x = 1/1r / x_rem
      break if x.infinite? || _convergents.include?([@ratioed_number.numerator, @ratioed_number.denominator])

      # Update the old values
      p_minus_1, q_minus_1 = p_0, q_0
      p_0, q_0 = p_n, q_n
      q = x.to_i
    end

    return _quotients, _convergents, _quotients.length
  end
end
