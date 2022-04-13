class Template
  class Assign < Node
    class Parser < Parslet::Parser
      rule(:assign_statement) { ::Template::Value::Parser.new }
      root(:assign_statement)
    end
  end
end
