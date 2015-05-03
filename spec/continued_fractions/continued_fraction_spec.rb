require File.join(File.dirname(__FILE__), "/../spec_helper")

describe ContinuedFraction do
  let(:cf) { described_class.new(number,10) }
  let(:number) { rand }
  
  it "should accurately calculate the convergents of a real number" do
    # First 10 convergents of PI are...
    convs = ['3/1', '22/7', '333/106', '355/113', '103993/33102', '104348/33215', '208341/66317', '312689/99532', '833719/265381', '1146408/364913'].map{|c| Rational(c)}
    cf = described_class.new(Math::PI,10)
    expect((ContinuedFractions.convergents_array_to_rationals(cf.convergents) - convs)).to be_empty
  end
  
  it "should return array for convergents method" do
    expect(cf.convergents).to be_kind_of(Array)
  end
  
  it "should preserve the number input" do
    expect(cf.number).to eq number
  end
  
  it "should contain convergents approaching the number" do
    0.upto(cf.convergents.length-2) do |i|
      convergent_rational_i_plus1, convergent_rational_i = ContinuedFractions.convergent_to_rational(cf.convergents[i+1]), ContinuedFractions.convergent_to_rational(cf.convergents[i])
      expect(((convergent_rational_i_plus1 - cf.number).abs <= (convergent_rational_i - cf.number).abs)).to be true
    end
  end
  
  it "should contain convergents which are expressed in lowest terms" do
    1.upto(cf.convergents.length-1) do |i|
      convergent_rational_i, convergent_rational_i_plus1 = ContinuedFractions.convergent_to_rational(cf.convergent(i)), ContinuedFractions.convergent_to_rational(cf.convergent(i+1))
      expect((convergent_rational_i.numerator*convergent_rational_i_plus1.denominator - convergent_rational_i_plus1.numerator*convergent_rational_i.denominator)).to eq (-1)**(i)
    end
  end
  
  it "should add a number (on the right-hand-side) with a continued fraction and return a continued fraction" do
    expect((cf + 3)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should subtract a number (on the right-hand-side) from a continued fraction and return a continued fraction" do
    expect((cf - 3)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should multiply a number (on the right-hand-side) with a continued fraction and return a continued fraction" do
    expect((cf * 3)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should divide a number (on the right-hand-side) with a continued fraction and return a continued fraction" do
    expect((cf / 3)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should add a continued fraction with another continued fraction and return a continued fraction" do
    c = described_class.new(rand,20)
    expect((cf + c)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should subtract a continued fraction with another continued fraction and return a continued fraction" do
    c = described_class.new(rand,20)
    expect((cf - c)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should multiply a continued fraction with another continued fraction and return a continued fraction" do
    c = described_class.new(rand,20)
    expect((cf * c)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should divide a continued fraction with another continued fraction and return a continued fraction" do
    c = described_class.new(rand,20)
    expect((cf / c)).to be_kind_of(ContinuedFractions::ContinuedFraction)
  end
  
  it "should assign the result continued fraction of a binary operation the max limit of the two operands" do
    c = described_class.new(rand,20)
    result = cf + c
    expect(result.limit).to eq [cf.limit,c.limit].max
  end
end