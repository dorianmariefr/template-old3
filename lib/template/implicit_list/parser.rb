class Template
  class ImplicitList
    class Parser < Parslet::Parser
      rule(:value) { ::Template::Value::Parser.new }
      rule(:call) { ::Template::Call::Parser.new }

      rule(:comma) { spaces? >> str(",") >> spaces? }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:implicit_value) { value | call }

      rule(:implicit_list) do
        (
          implicit_value.as(:first) >> comma >> implicit_value.as(:second) >>
            (comma >> implicit_value).repeat(1).as(:others).maybe >> comma.maybe
        ).as(:list)
      end

      root(:implicit_list)
    end
  end
end
