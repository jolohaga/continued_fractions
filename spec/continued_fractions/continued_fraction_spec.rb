require File.join(File.dirname(__FILE__), "/../spec_helper")

RSpec.describe ContinuedFraction do
  let(:cf) { described_class.new(number, limit) }
  let(:limit) { 10 }
  let(:number) { Math::PI }

  describe "initialization" do
    let(:cf) { described_class.new(number) }

    it { expect(cf).to be_a_kind_of(described_class) }
  end

  describe "#number" do
    it { expect(cf.number).to eq number }
  end

  describe "#limit" do
    let(:cf) { described_class.new(number) }

    it { expect(cf.limit).to eq 5 }

    context "automatic limit decrease" do
      let(:number) { 3/2r }
      let(:cf) { described_class.new(number, limit)}

      it { expect(cf.limit).to eq 2 }
    end

    context "manually increasing limit" do
      let(:cf) { described_class.new(number, limit) }

      it { expect(cf.limit).to eq limit }
    end
  end

  describe ".from_quotients" do
    let(:quotients) { [2, 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, 1, 1, 10, 1, 1, 12, 1, 1, 14] }
    let(:result) { described_class.from_quotients(quotients) }

    it "generates a continued fraction" do
      expect(result).to be_a_kind_of(described_class)
      expect(result.number).to eq Math::E
      expect(result.quotients.length).to eq quotients.length
    end
  end

  describe "#convergents" do
    it "returns an array" do
      expect(cf.convergents).to be_a_kind_of(Array)
    end

    context "with irrational numbers" do
      let(:number) { Math::PI }
      let(:cf) { described_class.new(number, 10) }
      let(:expected_convergents) {
        [Rational(3,1),
         Rational(22,7),
         Rational(333,106),
         Rational(355,113),
         Rational(103993,33102),
         Rational(104348,33215),
         Rational(208341,66317),
         Rational(312689,99532),
         Rational(833719,265381),
         Rational(1146408,364913)]
      }

      it "accurately calculates the convergents" do
        expect((cf.convergents - expected_convergents)).to be_empty
      end

      it "contains convergents approaching the number" do
        0.upto(cf.convergents.length-2) do |i|
          convergent_rational_i_plus1, convergent_rational_i = cf.convergents[i+1], cf.convergents[i]
          expect(((convergent_rational_i_plus1 - cf.number).abs <= (convergent_rational_i - cf.number).abs)).to be true
        end
      end

      it "contains convergents which are expressed in lowest terms" do
        0.upto(8) do |idx|
          convergent_rational_i, convergent_rational_i_plus1 = cf.convergents[idx], cf.convergents[idx+1]
          expect((convergent_rational_i.numerator*convergent_rational_i_plus1.denominator - convergent_rational_i_plus1.numerator*convergent_rational_i.denominator).abs).to eq 1
        end
      end
    end

    context "with finite expansion numbers" do
      let(:number) { [7/4r, 15/8r, 1.75, 35/18r].sample }
      let(:limit) { 10 }
      let(:cf) { described_class.new(number, limit) }

      it { expect(cf.convergents.length).to be < limit }
    end
  end

  describe "operations" do
    describe ".+" do
      let(:result) { described_class.new(Math::PI) + described_class.new(3.0)}

      it { expect(result).to eq described_class.new(Math::PI + 3.0) }
    end

    describe ".-" do
      let(:result) { described_class.new(Math::PI) - described_class.new(3.0)}

      it { expect(result).to eq described_class.new(Math::PI - 3.0) }
    end

    describe "./" do
      let(:result) { described_class.new(Math::PI) / described_class.new(3.0)}

      it { expect(result).to eq described_class.new(Math::PI / 3.0) }
    end

    describe ".-" do
      let(:result) { described_class.new(Math::PI) * described_class.new(3.0)}

      it { expect(result).to eq described_class.new(Math::PI * 3.0) }
    end
  end

  describe "comparison" do
    let(:cf) { described_class.new(Math::PI) }

    context "when numbers are the same" do
      it { expect(cf).to eq cf }
    end

    context "when numbers are different" do
      it { expect(cf < (cf + cf)).to be true }
      it { expect(cf > (cf - cf)).to be true }
      it { expect(cf < (cf * cf)).to be true }
      it { expect(cf > (cf / cf)).to be true }
    end
  end

  describe ".to_cf" do
    it { expect(1.5.to_cf).to be_a_kind_of(ContinuedFraction) }
  end
end
