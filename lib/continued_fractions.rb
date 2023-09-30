require 'continued_fractions/include'

# ContinuedFraction
#
# Generates quotients and convergents for a given number
#
# Author:: Jose Hales-Garcia (mailto:jose@halesgarcia.com)
# Copyright:: Copyright (c) 2023 Jose Hales-Garcia
#
#
class ContinuedFraction
  include Comparable

  attr_accessor :number, :quotients, :limit

  DEFAULT_LIMIT = 5

  # For a given number calculate its continued fraction quotients and convergents up to limit.
  #
  # The limit is 5 by default. Pass an integer in the second parameter to change it.
  #
  # Example:
  #   cf = ContinuedFraction.new(Math::PI,10)
  #   => #<ContinuedFractions::ContinuedFraction:0x000001010ed5c8 @number=3.14159265358979, @limit=10,
  #       @quotients=[3, 7, 15, 1, 292, 1, 1, 1, 2, 1],
  #       @convergents=[[0, 1], [1, 0], [3, 1], [22, 7], [333, 106],
  #                     [355, 113], [103993, 33102], [104348, 33215], [208341, 66317], [312689, 99532], [833719, 265381], [1146408, 364913]]>
  #
  def initialize(number, limit=DEFAULT_LIMIT)
    @number = number
    @ratioed_number = number.to_r
    @quotients, @convergents, @limit = calculate_quotients_and_convergents(number, limit)
  end

  # Return nth convergent.
  #
  # Example:
  #   cf = ContinuedFraction.new(Math::PI,10)
  #   cf.convergent(3)
  #   => [355,113]
  #
  def convergent(nth)
    raise(IndexError, "Convergent index must be greater than zero.") unless nth > 0
    convergents[nth-1]
  end

  # Return array of convergents of the continued fraction instance up to the nth convergent as an array
  # comprising of numerators in [i,0] and denominators in [i,1].
  # If nth is nil, then return the entire list.
  #
  # Example:
  #   cf = ContinuedFraction.new(Math::PI,10)
  #   cf.convergents
  #   => [[3,1], [22,7], [333,106], [355,113], [103993,33102],
  #       [104348,33215], [208341,66317], [312689,99532], [833719,265381], [1146408,364913]]
  #
  # Or:
  #   cf.convergents(3)
  #   => [[3,1], [22,7], [333,106]]
  #
  def convergents(nth=nil)
    nth ||= @convergents.length
    @convergents[0...nth]
  end

  # Return array of convergents of the continued fraction instance converted as Rationals.
  # If nth is nil, then return the entire list.
  #
  # Example:
  #   cf = ContinuedFraction.new(Math::PI,10)
  #   cf.convergents_as_rationals
  #   => [(3/1), (22/7), (333/106), (355/113), (103993/33102),
  #       (104348/33215), (208341/66317), (312689/99532), (833719/265381), (1146408/364913)]
  #
  # Or:
  #   cf.convergents_as_rationals(3)
  #   => [(3/1), (22/7), (333/106)]
  #
  def convergents_as_rationals(nth=nil)
    nth ||= convergents.length
    convergents[0...nth].map{|convergent| convergent_to_rational(convergent)}
  end

  def +(other)
    number_of(other) do |num,prec|
      evaluate("#{number} + #{num}",prec)
    end
  end

  def -(other)
    number_of(other) do |num,prec|
      evaluate("#{number} - #{num}",prec)
    end
  end

  def /(other)
    number_of(other) do |num,prec|
      evaluate("#{number} / #{num}",prec)
    end
  end

  def *(other)
    number_of(other) do |num,prec|
      evaluate("#{number} * #{num}",prec)
    end
  end

  def <=>(other)
    number <=> other.number
  end

  def convergent_to_rational(convergent) #:nodoc:
    Rational(convergent[0],convergent[1])
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

  def calculate_quotients_and_convergents(x, limit)
    _quotients = []
    _convergents = []

    # Initialize the initial values for p and q
    p_minus_1, q_minus_1 = 0, 1
    p_0, q_0 = 1, 0

    n = x.to_i

    # Loop for maximum specified terms or until the fractional part becomes zero
    limit.times do
      _quotients << n

      # Calculate the new p and q
      p_n = n * p_0 + p_minus_1
      q_n = n * q_0 + q_minus_1

      _convergents << [p_n, q_n]

      # Recalculate the fractional part
      x = 1.0 / (x - n)
      break if x.infinite? || _convergents.include?([@ratioed_number.numerator, @ratioed_number.denominator])

      # Update the old values
      p_minus_1, q_minus_1 = p_0, q_0
      p_0, q_0 = p_n, q_n
      n = x.to_i
    end

    return _quotients, _convergents, _quotients.length
  end
end

# @return [ContinuedFraction] new instance
# @see ContinuedFraction#initialize
#
def ContinuedFraction(number,limit=ContinuedFraction::DEFAULT_LIMIT)
  ContinuedFraction.new(number,limit)
end
