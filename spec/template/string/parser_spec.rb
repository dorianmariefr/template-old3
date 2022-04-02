require "spec_helper"

RSpec.describe Template::String::Parser do
  subject { described_class.new.parse(input) }

  context '"\'hello\'"' do
    let(:input) { "'hello'" }

    it { is_expected.to eq("hello") }
  end

  context "\"\"hello\"\"" do
    let(:input) { "\"hello\"" }

    it { is_expected.to eq("hello") }
  end

  context '""new\nline""' do
    let(:input) { '"new\nline"' }

    it { is_expected.to eq('new\nline') }
  end

  context '"\'new\nline\'"' do
    let(:input) { "'new\\nline'" }

    it { is_expected.to eq('new\nline') }
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
