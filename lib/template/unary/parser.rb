class Template
  class Unary < Node
    class Parser < Parslet::Parser
      rule(:value) { ::Template::Value::Parser.new }
      rule(:unary) do
        value
      end
      root(:unary)
    end
  end
end
