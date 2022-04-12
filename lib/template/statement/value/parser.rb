class Template
  class Statement < Node
    class Value < Node
      class Parser < Parslet::Parser
        rule(:value) { ::Template::Value::Parser.new }

        rule(:value_statement) { value }
        root(:value_statement)
      end
    end
  end
end
