class Template
  class Code < Node
    class Parser < Parslet::Parser
      rule(:statement) { ::Template::Statement::Parser.new }
      rule(:code) { statement.repeat(1).as(:code) }
      root(:code)
    end
  end
end
