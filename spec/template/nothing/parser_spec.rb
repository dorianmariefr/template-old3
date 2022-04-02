require "spec_helper"

RSpec.describe Template::Nothing::Parser do
  subject { described_class.new.parse(input) }

  context '"nothing"' do
    let(:input) { "nothing" }

    it { is_expected.to eq(nothing: "nothing") }
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
