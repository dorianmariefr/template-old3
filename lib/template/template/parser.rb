class Template
  class Template < Node
    class Parser < Parslet::Parser
      rule(:part) { ::Template::Part::Parser.new }
      rule(:template) { part.repeat(0).as(:template) }
      root(:template)
    end
  end
end
