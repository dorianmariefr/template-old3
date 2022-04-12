class Template
  class KeyValue < Node
    class Parser < Parslet::Parser
      rule(:name) { ::Template::Name::Parser.new }
      rule(:code) { ::Template::Code::Parser.new }

      rule(:colon) { str(":") >> spaces? }
      rule(:arrow) { spaces? >> str("=>") >> spaces? }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:key_value) do
        (name.as(:string).as(:value).as(:key) >> colon >> code.as(:value)) |
          (code.as(:key) >> arrow >> code.as(:value))
      end

      root(:key_value)
    end
  end
end
