class Template
  class Call
    class Parser < Parslet::Parser
      rule(:name) { ::Template::Name::Parser.new }
      rule(:call) { name.as(:name).as(:call) }
      root(:call)
    end
  end
end
