class Template
  class Rescue < Node
    class Parser < Parslet::Parser
      rule(:ternary) { ::Template::Ternary::Parser.new }

      rule(:rescue_keyword) { str("rescue") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:rescue_statement) do
        (
          ternary.as(:left) >> spaces? >> rescue_keyword >> spaces? >>
            rescue_statement.as(:right)
        ).as(:rescue) | ternary
      end

      root(:rescue_statement)
    end
  end
end
