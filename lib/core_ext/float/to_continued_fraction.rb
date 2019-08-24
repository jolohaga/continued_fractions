##
# Give Float the ability to convert itself to its ContinuedFraction
# representation.
#
class Float
  def to_continued_fraction(limit = ContinuedFraction.default_limit)
    ContinuedFraction.new(self, limit)
  end
end
