class Template
  class Dictionnary < Node
    class Parser < Parslet::Parser
      rule(:left_curly_bracket) { str("{") >> spaces? }
      rule(:right_curly_bracket) { spaces? >> str("}") }
      rule(:comma) { spaces? >> str(",") >> spaces? }
      rule(:colon) { str(":") >> spaces? }
      rule(:arrow) { spaces? >> str("=>") >> spaces? }
      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }

      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:name) { ::Template::Name::Parser.new.as(:string) }
      rule(:value) { ::Template::Value::Parser.new }

      rule(:key_value) do
        (name.as(:key) >> colon >> value.as(:value)) |
          (value.as(:key) >> colon >> value.as(:value)) |
          (value.as(:key) >> arrow >> value.as(:value))
      end

      rule(:dictionnary) do
        (
          left_curly_bracket.ignore >>
            (
              key_value.as(:first) >>
                (comma >> key_value).repeat(1).as(:others).maybe >> comma.maybe
            ).maybe >> right_curly_bracket.ignore
        ).as(:dictionnary)
      end

      root(:dictionnary)
    end
  end
end
