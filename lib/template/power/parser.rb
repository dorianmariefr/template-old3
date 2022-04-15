class Template
  class Power < Node
    class Parser < Parslet::Parser
      rule(:unary) { ::Template::Unary::Parser.new }

      rule(:times_times) { str("**") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) { times_times }

      rule(:power) do
        (
          unary.as(:left) >> spaces? >> operator.as(:operator) >> spaces? >> power.as(:right)
        ).as(:power) | unary
      end

      root(:power)
    end
  end
end
