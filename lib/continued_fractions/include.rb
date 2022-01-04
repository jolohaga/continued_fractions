module ContinuedFractions
  module Numeric
    def to_cf(limit: ContinuedFraction::DEFAULT_LIMIT)
      ContinuedFraction.new(self, limit)
    end
    alias :to_continued_fraction :to_cf
  end
end

Float.include(ContinuedFractions::Numeric)
Integer.include(ContinuedFractions::Numeric)
Rational.include(ContinuedFractions::Numeric)
