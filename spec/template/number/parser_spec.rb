require "spec_helper"

RSpec.describe Template::Number::Parser do
  subject { described_class.new.parse(input) }

  [
    {
      input: "1",
      output: { base_10: { whole: "1" } }
    },
    {
      input: "1.2",
      output: { base_10: { whole: "1", decimal: "2" } }
    },
    {
      input: ".2",
      output: { base_10: { decimal: "2" } }
    },
    {
      input: ".2e1",
      output: { base_10: { decimal: "2", exponent: { base_10: { whole: "1" } } } }
    },
    {
      input: "10.20",
      output: { base_10: { whole: "10", decimal: "20" } }
    },
    {
      input: "2e1",
      output: { base_10: { whole: "2", exponent: { base_10: { whole: "1" } } } }
    },
    {
      input: "0b01010",
      output: { base_2: "01010" }
    },
    {
      input: "0o172",
      output: { base_8: "172" }
    },
    {
      input: "0xabc0",
      output: { base_16: "abc0" }
    },
  ].each do |spec|
    context spec[:input].inspect do
      let(:input) { spec[:input] }

      it { is_expected.to eq(spec[:output]) }
    end
  end

  context "\"\"" do
    let(:input) { "" }

    it { expect { subject }.to raise_error(Parslet::ParseFailed) }
  end

  context "\"something else\"" do
    let(:input) { "something else" }

    it { expect { subject }.to raise_error(Parslet::ParseFailed) }
  end
end
