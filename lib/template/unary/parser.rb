class Template
  class Unary < Node
    class Parser < Parslet::Parser
      rule(:value) { ::Template::Value::Parser.new }

      rule(:exclamation_point) { str("!") }
      rule(:tilde) { str("~") }
      rule(:plus) { str("+") }
      rule(:minus) { str("-") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) { exclamation_point | tilde | plus | minus }

      rule(:unary) do
        (
          operator.as(:operator) >> spaces? >> unary.as(:body)
        ).as(:unary) | value
      end
      root(:unary)
    end
  end
end
