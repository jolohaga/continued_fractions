require File.join(File.dirname(__FILE__), "/../spec_helper")

describe "Float#_to_continued_fraction" do
  let(:example_float) { Math::PI }

  it "converts float to its continued fraction representation" do
    subject = example_float.to_continued_fraction
    explicit_cf = ContinuedFraction.new(example_float)

    expect(explicit_cf.number).to eq(subject.number)
    expect(explicit_cf.limit).to eq(subject.limit)
  end

  it "can accept an explicit limit" do
    limit = rand(3..20)
    subject = example_float.to_continued_fraction(limit)
    explicit_cf = ContinuedFraction.new(example_float, limit)

    expect(explicit_cf.number).to eq(subject.number)
    expect(explicit_cf.limit).to eq(subject.limit)
  end
end
