class Template
  class List < Node
    class Parser < Parslet::Parser
      rule(:plus_statement) { ::Template::Statement::Plus::Parser.new }

      rule(:left_square_bracket) { str("[") >> spaces? }
      rule(:right_square_bracket) { spaces? >> str("]") }
      rule(:comma) { spaces? >> str(",") >> spaces? }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:list) do
        (
          left_square_bracket.ignore >>
            (
              plus_statement.as(:first) >>
                (comma >> plus_statement).repeat(1).as(:others).maybe >> comma.maybe
            ).maybe >> right_square_bracket.ignore
        ).as(:list)
      end

      root(:list)
    end
  end
end
