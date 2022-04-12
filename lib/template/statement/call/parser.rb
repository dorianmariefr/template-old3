class Template
  class Statement < Node
    class Call < Node
      class Parser < Parslet::Parser
        rule(:call) { ::Template::Call::Parser.new }
        rule(:value_statement) { ::Template::Statement::Value::Parser.new }

        rule(:call_statement) { call | value_statement }
        root(:call_statement)
      end
    end
  end
end
