class Template
  class ImplicitDictionnary
    class Parser < Parslet::Parser
      rule(:plus_statement) { ::Template::Statement::Plus::Parser.new }
      rule(:name) { ::Template::Name::Parser.new }

      rule(:comma) { spaces? >> str(",") >> spaces? }
      rule(:colon) { str(":") >> spaces? }
      rule(:arrow) { spaces? >> str("=>") >> spaces? }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:implicit_value) { plus_statement }

      rule(:implicit_key_value) do
        name.as(:string).as(:value).as(:key) >> colon >>
          implicit_value.as(:value) |
          implicit_value.as(:key) >> arrow >> implicit_value.as(:value)
      end

      rule(:implicit_list) do
        (
          implicit_key_value.as(:first) >>
            (comma >> implicit_key_value).repeat(1).as(:others).maybe >>
            comma.maybe
        ).as(:dictionnary)
      end

      root(:implicit_list)
    end
  end
end
