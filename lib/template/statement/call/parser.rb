class Template
  class Statement < Node
    class Call < Node
      class Parser < Parslet::Parser
        rule(:call) { ::Template::Call::Parser.new }
        rule(:call_statement) { call }
        root(:call_statement)
      end
    end
  end
end
