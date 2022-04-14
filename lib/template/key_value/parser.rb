class Template
  class KeyValue < Node
    class Parser < Parslet::Parser
      rule(:name) { ::Template::Name::Parser.new }
      rule(:modifier) { ::Template::Modifier::Parser.new }

      rule(:colon) { str(":") >> spaces? }
      rule(:arrow) { spaces? >> str("=>") >> spaces? }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:key_value) do
        (name.as(:string).as(:value).as(:key) >> colon >> modifier.as(:value)) |
          (modifier.as(:key) >> arrow >> modifier.as(:value))
      end

      root(:key_value)
    end
  end
end
