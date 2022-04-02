class Template
  class List
    class Parser < Parslet::Parser
      rule(:left_square_bracket) { str("[") >> spaces? }
      rule(:right_square_bracket) { spaces? >> str("]") }
      rule(:comma) { spaces? >> str(",") >> spaces? }
      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }

      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:value) { Template::Value::Parser.new }

      rule(:list) do
        left_square_bracket.ignore >>
          (value.as(:first) >> (comma >> value).repeat(1).as(:others).maybe)
            .maybe >> right_square_bracket.ignore
      end

      root(:list)
    end
  end
end
