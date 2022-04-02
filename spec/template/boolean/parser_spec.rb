require "spec_helper"

RSpec.describe Template::Boolean::Parser do
  subject { described_class.new.parse(input) }

  context '"true"' do
    let(:input) { "true" }

    it { is_expected.to eq(boolean: "true") }
  end

  context '"false"' do
    let(:input) { "false" }

    it { is_expected.to eq(boolean: "false") }
  end

  context '""' do
    let(:input) { "" }

    it { expect { subject }.to raise_error(Parslet::ParseFailed) }
  end

  context '"something else"' do
    let(:input) { "something else" }

    it { expect { subject }.to raise_error(Parslet::ParseFailed) }
  end
end
