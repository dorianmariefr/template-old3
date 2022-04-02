require "spec_helper"

RSpec.describe Template::Name::Parser do
  subject { described_class.new.parse(input) }

  [
    { input: "a", output: "a" },
    { input: "hello", output: "hello" },
    { input: "with_underscore", output: "with_underscore" },
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
