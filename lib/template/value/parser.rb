class Template
  class Value
    class Parser < Parslet::Parser
      rule(:nothing) { Template::Nothing::Parser.new }
      rule(:boolean) { Template::Boolean::Parser.new }
      rule(:number) { Template::Number::Parser.new }
      rule(:string) { Template::String::Parser.new }
      rule(:value) do
        nothing.as(:nothing) |
          boolean.as(:boolean) |
          number.as(:number) |
          string.as(:string)
      end
      root(:value)
    end
  end
end
