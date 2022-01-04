require File.join(File.dirname(__FILE__), "/../spec_helper")

describe ContinuedFraction do
  let(:cf) { described_class.new(number, 10) }
  let(:number) { rand }

  describe 'initialize' do
    context 'with Integer, Float and Rational' do
      let(:number) { [3/2r, 1.5, 10].sample }
      let(:cf) { described_class.new(number) }

      it 'initializes a continued fraction' do
        expect(cf).to be_kind_of(ContinuedFraction)
        expect(cf.number).to eq number
      end
    end

    describe 'ContinuedFraction(...)' do
      let(:number) { Math::PI }
      let(:cf) { ContinuedFraction(number) }

      it 'initializes a continued fraction' do
        expect(cf).to be_kind_of(ContinuedFraction)
        expect(cf.number).to eq Math::PI
      end
    end

    describe 'limit' do
      let(:number) { Math::PI }
      let(:cf) { ContinuedFraction.new(number) }

      context 'unspecified' do
        it 'length of quotients and convergents are DEFAULT_LIMIT' do
          expect(cf.quotients.count).to eq ContinuedFraction::DEFAULT_LIMIT
          expect(cf.convergents.count).to eq ContinuedFraction::DEFAULT_LIMIT
        end
      end

      context 'when provided' do
        let(:limit) { rand(20) }

        context 'with an infinite continued fraction' do
          let(:number) { Math::PI }
          let(:cf) { ContinuedFraction.new(number, limit) }

          it 'length of quotients and convergents are "limit"' do
            expect(cf.quotients.count).to eq limit
            expect(cf.convergents.count).to eq limit
          end
        end

        context 'with a finite continued fraction' do
          let(:number) { 3/2r }
          let(:limit) { rand(2..20) }
          let(:cf) { ContinuedFraction.new(number, limit) }

          it 'length of quotients and convergents do not exceed "limit"' do
            expect(cf.quotients.count).to be <= limit
            expect(cf.convergents.count).to be <= limit
          end
        end
      end
    end
  end

  describe '#convergents' do
    it "returns an array" do
      expect(cf.convergents).to be_kind_of(Array)
    end

    context 'with irrational numbers' do
      it "accurately calculates the convergents" do
        # First 10 convergents of PI are...
        convs = [3/1r, 22/7r, 333/106r, 355/113r, 103993/33102r, 104348/33215r, 208341/66317r, 312689/99532r, 833719/265381r, 1146408/364913r]
        cf = described_class.new(Math::PI,10)
        expect((cf.convergents_as_rationals - convs)).to be_empty
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

    context 'with rational numbers' do
      it 'changes the limit to the number of convergents calculated' do
        expect(described_class.new(1.5, 10).limit).to be 2
      end
    
      it 'calculates the convergents' do
        convs = [ 1/1r, 3/2r ]
        expect(described_class.new(1.5, 10).convergents_as_rationals - convs).to be_empty
      end
    end
  end

  describe '#number' do
    it "preserves the number input" do
      expect(cf.number).to eq number
    end
  end

  describe 'operators' do
    let(:cf2) { described_class.new(rand, 20) }

    %i{+ - * /}.each do |op|
      describe "#{op}" do
        [3, 3.0, 3/1r, described_class.new(rand, 20)].each do |rhs|
          it "#{rhs.class.name} operates on the right-hand side and returns a ContinuedFraction" do
            expect(cf.send(op, rhs)).to be_kind_of(ContinuedFraction)
          end
        end

        it "Assigns the max limit of the two operands" do
          result = cf.send(op, cf2)
          expect(result.limit).to eq [cf.limit, cf2.limit].max
        end
      end
    end
  end

  describe 'comparing' do
    context 'when numbers are the same' do
      let(:cf2) { described_class.new(cf.number) }

      it "the ContinuedFractions are equal" do
        expect(cf).to eq cf2
      end
    end

    context 'when numbers are different' do
      let(:cond) { [['+', '<'], ['-', '>']].sample }
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
      explicit_cf = ContinuedFraction.new(number)

      expect(explicit_cf.number).to eq(converted_cf.number)
      expect(explicit_cf.limit).to eq(converted_cf.limit)
    end

    it "can accept a limit" do
      limit = rand(3..20)
      converted_cf = number.to_cf(limit: limit)
      explicit_cf = ContinuedFraction.new(number, limit)

      expect(explicit_cf.number).to eq(converted_cf.number)
      expect(explicit_cf.limit).to eq(converted_cf.limit)
    end
  end
end