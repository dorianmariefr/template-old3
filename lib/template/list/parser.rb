class Template
  class List < Node
    class Parser < Parslet::Parser
      rule(:modifier) { ::Template::Modifier::Parser.new }

      rule(:left_square_bracket) { str("[") }
      rule(:right_square_bracket) { str("]") }
      rule(:comma) { str(",") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:list) do
        (
          left_square_bracket.ignore >> spaces?.ignore >>
            (
              modifier.as(:first) >>
                (spaces? >> comma >> spaces? >> modifier)
                  .repeat(1)
                  .as(:others)
                  .maybe >> spaces? >> comma.maybe >> spaces?
            ).maybe >> spaces?.ignore >> right_square_bracket.ignore
        ).as(:list)
      end

      root(:list)
    end
  end
end
