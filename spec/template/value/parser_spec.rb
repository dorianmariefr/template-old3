# typed: false
require "spec_helper"

RSpec.describe Template::Value::Parser do
  subject { described_class.new.parse(input) }

  [
    { input: "1", output: { number: { base_10: { whole: "1" } } } },
    { input: "true", output: { boolean: "true" } },
    { input: "nothing", output: { nothing: "nothing" } },
    { input: "'hello'", output: { string: "hello" } },
    { input: "[true]", output: { list: { first: { boolean: "true" } } } },
    {
      input: "{a:true}",
      output: {
        dictionnary: {
          first: {
            key: {
              string: "a"
            },
            value: {
              boolean: "true"
            }
          }
        }
      }
    }
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
