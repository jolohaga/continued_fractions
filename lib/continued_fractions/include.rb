module ContinuedFractions
  module Numeric

    # @return [ContinuedFraction]
    # @example
    #   1.5.to_cf
    #   => 1.5, quotients: [1, 2], convergents: [(1/1), (3/2)]
    # @param limit [Float]
    #
    def to_cf(limit: ContinuedFraction::DEFAULT_LIMIT)
      ContinuedFraction.new(self, limit)
    end
  end
end

Float.include(ContinuedFractions::Numeric)
Integer.include(ContinuedFractions::Numeric)
Rational.include(ContinuedFractions::Numeric)
