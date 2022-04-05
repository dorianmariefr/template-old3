class Template
  class Call < Node
    class Parser < Parslet::Parser
      rule(:name) { ::Template::Name::Parser.new }
      rule(:call) { name.as(:name).as(:call) }
      root(:call)
    end
  end
end
