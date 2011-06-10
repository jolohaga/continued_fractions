require File.join(File.dirname(__FILE__), "/../spec_helper")

module ContinuedFractions
  describe ContinuedFraction do
    it "should accurately calculate the convergents of a real number" do
      # First 10 convergents of PI are...
      convs = ['3/1', '22/7', '333/106', '355/113', '103993/33102', '104348/33215', '208341/66317', '312689/99532', '833719/265381', '1146408/364913'].map{|c| Rational(c)}
      @cf = ContinuedFraction.new(Math::PI,10)
      (ContinuedFractions.convergents_array_to_rationals(@cf.convergents) - convs).empty?.should == true
    end
    
    before(:each) do
      @number = rand
      @cf = ContinuedFraction.new(@number,10)
    end
    
    it "should return array for convergents method" do
      @cf.convergents.class.should == Array
    end
    
    it "should preserve the number input" do
      @cf.number.should == @number
    end
    
    it "should contain convergents approaching the number" do
      0.upto(@cf.convergents.length-2) do |i|
        convergent_rational_i_plus1, convergent_rational_i = ContinuedFractions.convergent_to_rational(@cf.convergents[i+1]), ContinuedFractions.convergent_to_rational(@cf.convergents[i])
        ((convergent_rational_i_plus1 - @cf.number).abs <= (convergent_rational_i - @cf.number).abs).should == true
      end
    end
    
    it "should contain convergents which are expressed in lowest terms" do
      1.upto(@cf.convergents.length-1) do |i|
        convergent_rational_i, convergent_rational_i_plus1 = ContinuedFractions.convergent_to_rational(@cf.convergent(i)), ContinuedFractions.convergent_to_rational(@cf.convergent(i+1))
        (convergent_rational_i.numerator*convergent_rational_i_plus1.denominator - convergent_rational_i_plus1.numerator*convergent_rational_i.denominator).should == (-1)**(i)
      end
    end
    
    it "should add a number (on the right-hand-side) with a continued fraction and return a continued fraction" do
      (@cf + 3).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should subtract a number (on the right-hand-side) from a continued fraction and return a continued fraction" do
      (@cf - 3).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should multiply a number (on the right-hand-side) with a continued fraction and return a continued fraction" do
      (@cf * 3).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should divide a number (on the right-hand-side) with a continued fraction and return a continued fraction" do
      (@cf / 3).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should add a continued fraction with another continued fraction and return a continued fraction" do
      c = ContinuedFraction.new(rand,20)
      (@cf + c).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should subtract a continued fraction with another continued fraction and return a continued fraction" do
      c = ContinuedFraction.new(rand,20)
      (@cf - c).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should multiply a continued fraction with another continued fraction and return a continued fraction" do
      c = ContinuedFraction.new(rand,20)
      (@cf * c).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should divide a continued fraction with another continued fraction and return a continued fraction" do
      c = ContinuedFraction.new(rand,20)
      (@cf / c).class.should == ContinuedFractions::ContinuedFraction
    end
    
    it "should assign the result continued fraction of a binary operation the max limit of the two operands" do
      c = ContinuedFraction.new(rand,20)
      result = @cf + c
      result.limit.should == [@cf.limit,c.limit].max
    end
  end
end