require "spec_helper"

RSpec.describe Template::Dictionnary::Parser do
  subject { described_class.new.parse(input) }

  [
    { input: "{}", output: "" },
    {
      input: "{a:1}",
      output: {
        first: {
          key: {
            string: "a"
          },
          value: {
            number: {
              base_10: {
                whole: "1"
              }
            }
          }
        }
      }
    },
    {
      input: "{'a' => true, b: false }",
      output: {
        first: {
          key: {
            string: "a"
          },
          value: {
            boolean: "true"
          }
        },
        others: [{ key: { string: "b" }, value: { boolean: "false" } }]
      }
    },
    {
      input: "{1 => [1, 2,], b: {a:1}, }",
      output: {
        first: {
          key: {
            number: {
              base_10: {
                whole: "1"
              }
            }
          },
          value: {
            list: {
              first: {
                number: {
                  base_10: {
                    whole: "1"
                  }
                }
              },
              others: [{ number: { base_10: { whole: "2" } } }]
            }
          }
        },
        others: [
          {
            key: {
              string: "b"
            },
            value: {
              dictionnary: {
                first: {
                  key: {
                    string: "a"
                  },
                  value: {
                    number: {
                      base_10: {
                        whole: "1"
                      }
                    }
                  }
                }
              }
            }
          }
        ]
      }
    }
  ].each do |spec|
    context spec[:input].inspect do
      let(:input) { spec[:input] }

      it { is_expected.to eq(dictionnary: spec[:output]) }
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
