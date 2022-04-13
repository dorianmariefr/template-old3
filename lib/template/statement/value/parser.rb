class Template
  class Statement < Node
    class Value < Node
      class Parser < Parslet::Parser
        rule(:call_statement) { ::Template::Statement::Call::Parser.new }
        rule(:value) { ::Template::Value::Parser.new }

        rule(:value_statement) { value | call_statement }
        root(:value_statement)
      end
    end
  end
end
