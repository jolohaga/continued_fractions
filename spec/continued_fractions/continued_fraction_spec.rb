require File.join(File.dirname(__FILE__), "/../spec_helper")

RSpec.describe ContinuedFraction do
  let(:cf) { described_class.new(number, limit) }
  let(:limit) { 10 }
  let(:number) { rand }

  describe "initialization" do
    let(:cf) { described_class.new(number) }
    let(:number) { [3/2r, 1.5, 10].sample }

    it "initializes a continued fraction" do
      expect(cf).to be_a_kind_of(described_class)
    end

    it "accepts a number" do
      expect(cf.number).to eq number
    end

    context "with irrational numbers" do
      let(:number) { Math::PI }

      it "sets the limit to 5 by default" do
        expect(cf.limit).to eq 5
      end

      it "quotient and convergent lists are 5 long by default" do
        expect(cf.convergents.length).to eq 5
        expect(cf.quotients.length).to eq 5
      end

      context "increasing limit" do
        let(:cf) { described_class.new(number, limit) }
        let(:limit) { 10 }

        it "quotient and convergent lists are limit long" do
          expect(cf.convergents.length).to eq 10
          expect(cf.quotients.length).to eq 10
        end
      end
    end

    context "with finite expansion numbers" do
      let(:number) { [7/4r, 15/8r, 1.75, 35/18r].sample }
      let(:limit) { 10 }
      let(:cf) { described_class.new(number, limit) }

      it "length of quotients and convergents do not exceed 'limit'" do
        puts "#{cf.quotients}"
        expect(cf.quotients.length).to be <= limit
        expect(cf.convergents.length).to be <= limit
      end
    end

    describe "ContinuedFraction(...)" do
      let(:number) { Math::PI }
      let(:cf) { ContinuedFraction(number) }

      it "initializes a continued fraction" do
        expect(cf).to be_a_kind_of(described_class)
        expect(cf.number).to eq Math::PI
      end
    end
  end

  describe "#convergents" do
    it "returns an array" do
      expect(cf.convergents).to be_a_kind_of(Array)
    end

    context "with irrational numbers" do
      let(:cf) { described_class.new(cf_data.first, 10) }
      let(:cf_data) { [Math::PI, [3/1r, 22/7r, 333/106r, 355/113r, 103993/33102r, 104348/33215r, 208341/66317r, 312689/99532r, 833719/265381r, 1146408/364913r]] }

      it "accurately calculates the convergents" do
        # First 10 convergents of PI are...
        expect((cf.convergents_as_rationals - cf_data.last)).to be_empty
      end

      it "contains convergents approaching the number" do
        0.upto(cf.convergents.length-2) do |i|
          convergent_rational_i_plus1, convergent_rational_i = cf.convergent_to_rational(cf.convergents[i+1]), cf.convergent_to_rational(cf.convergents[i])
          expect(((convergent_rational_i_plus1 - cf.number).abs <= (convergent_rational_i - cf.number).abs)).to be true
        end
      end

      it "contains convergents which are expressed in lowest terms" do
        1.upto(cf.convergents.length-1) do |i|
          convergent_rational_i, convergent_rational_i_plus1 = cf.convergent_to_rational(cf.convergent(i)), cf.convergent_to_rational(cf.convergent(i+1))
          expect((convergent_rational_i.numerator*convergent_rational_i_plus1.denominator - convergent_rational_i_plus1.numerator*convergent_rational_i.denominator)).to eq (-1)**(i)
        end
      end
    end

    context "with rational numbers" do
      let(:cf_data) { [[3/2r, [1/1r, 3/2r]], [35/18r, [1/1r, 2/1r, 33/17r, 35/18r]]].sample }

      it "changes the limit to the number of convergents calculated" do
        expect(described_class.new(cf_data.first, 10).limit).to be cf_data.last.count
      end
    
      it "calculates the convergents" do
        expect(described_class.new(cf_data.first, 10).convergents_as_rationals - cf_data.last).to be_empty
      end
    end
  end

  describe "operations" do
    let(:cf2) { described_class.new(rand, 20) }

    %i{+ - * /}.each do |op|
      describe "#{op}" do
        [3, 3.0, 3/1r, described_class.new(rand, 20)].each do |rhs|
          it "#{rhs.class.name} operates on the right-hand side and returns a ContinuedFraction" do
            expect(cf.send(op, rhs)).to be_a_kind_of(described_class)
          end
        end

        it "Assigns the max limit of the two operands" do
          result = cf.send(op, cf2)
          expect(result.limit).to eq [cf.limit, cf2.limit].max
        end
      end
    end
  end

  describe "comparison" do
    context "when numbers are the same" do
      let(:cf2) { described_class.new(cf.number) }

      it "the ContinuedFractions are equal" do
        expect(cf).to eq cf2
      end
    end

    context "when numbers are different" do
      let(:cond) { [["+", "<"], ["-", ">"]].sample }
      let(:cf2) { described_class.new(cf.number.send(cond[0], 1.0)) }

      it "the ContinuedFractions are unequal" do
        expect(cf.send(cond[1], cf2)).to be true
      end
    end
  end

  describe "(Integer|Rational|Float)#to_cf" do
    let(:number) { [Math::PI, 1.5, 3/2r, 20].sample }

    it "converts float to its continued fraction representation" do
      converted_cf = number.to_cf
      explicit_cf = described_class.new(number)

      expect(explicit_cf.number).to eq(converted_cf.number)
      expect(explicit_cf.limit).to eq(converted_cf.limit)
    end

    it "can accept a limit" do
      limit = rand(3..20)
      converted_cf = number.to_cf(limit: limit)
      explicit_cf = described_class.new(number, limit)

      expect(explicit_cf.number).to eq(converted_cf.number)
      expect(explicit_cf.limit).to eq(converted_cf.limit)
    end
  end
end