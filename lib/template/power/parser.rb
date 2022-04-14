class Template
  class Power < Node
    class Parser < Parslet::Parser
      rule(:unary) { ::Template::Unary::Parser.new }
      rule(:power) { unary }
      root(:power)
    end
  end
end
