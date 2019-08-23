# ContinuedFractions
#
# Generates quotients and convergents for a given number
#
# Author:: Jose Hales-Garcia (mailto:jolohaga@me.com)
# Copyright:: Copyright (c) 2015 Jose Hales-Garcia
#
#
class ContinuedFraction
  attr_accessor :number, :quotients, :limit
  
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
  def initialize(number,limit=5)
    @number = number
    @limit = limit
    @quotients = calculate_quotients
    @convergents = calculate_convergents
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
    when Fixnum, Integer
      num = n
      prec = limit
    when ContinuedFraction
      num = n.number
      prec = [n.limit,limit].max
    end
    yield(num,prec)
  end

  def calculate_quotients #:nodoc:
    n = number
    Array.new(limit).tap do |qs|
      limit.times do |i|
        qs[i] = n.to_i
        break if ((divisor = n-qs[i]) == 0.0)
        n = 1.0/divisor
      end
      self.limit = qs.compact.length
    end.compact
  end

  def calculate_convergents #:nodoc:
    convs = convergence_matrix(quotients.length+2,2,1)
    nth ||= convs.length
    2.upto(quotients.length+1) do |i|
      i_minus1,i_minus2 = i-1,i-2
      convs[i][0] = convs[i_minus1][0]*quotients[i_minus2]+convs[i_minus2][0]
      convs[i][1] = convs[i_minus1][1]*quotients[i_minus2]+convs[i_minus2][1]
    end
    convs[2...nth+2]
  end
  
  def convergence_matrix(n,m,fill=nil) #:nodoc:
    conv_mat = Array.new(n).map!{Array.new(m,fill)}
    conv_mat[0][0],conv_mat[1][1] = 0,0
    conv_mat
  end
end
