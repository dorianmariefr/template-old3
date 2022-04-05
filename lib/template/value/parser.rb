class Template
  class Value < Node
    class Parser < Parslet::Parser
      rule(:nothing) { ::Template::Nothing::Parser.new }
      rule(:boolean) { ::Template::Boolean::Parser.new }
      rule(:number) { ::Template::Number::Parser.new }
      rule(:string) { ::Template::String::Parser.new }
      rule(:dictionnary) { ::Template::Dictionnary::Parser.new }
      rule(:list) { ::Template::List::Parser.new }
      rule(:call) { ::Template::Call::Parser.new }
      rule(:value) do
        nothing | boolean | number | string | dictionnary | list | call
      end
      root(:value)
    end
  end
end
