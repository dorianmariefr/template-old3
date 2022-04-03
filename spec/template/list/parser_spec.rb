# typed: false
require "spec_helper"

RSpec.describe Template::Value::Parser do
  subject { described_class.new.parse(input) }

  [
    { input: "[]", output: "" },
    {
      input: "[1]",
      output: {
        first: {
          number: {
            base_10: {
              whole: "1"
            }
          }
        }
      }
    },
    {
      input: "[true, false]",
      output: {
        first: {
          boolean: "true"
        },
        others: [{ boolean: "false" }]
      }
    },
    {
      input: "[[[true]]]",
      output: {
        first: {
          list: {
            first: {
              list: {
                first: {
                  boolean: "true"
                }
              }
            }
          }
        }
      }
    }
  ].each do |spec|
    context spec[:input].inspect do
      let(:input) { spec[:input] }

      it { is_expected.to eq(list: spec[:output]) }
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
