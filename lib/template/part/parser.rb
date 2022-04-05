class Template
  class Part < Node
    class Parser < Parslet::Parser
      rule(:left_curly_brace) { str("{") }
      rule(:right_curly_brace) { str("}") }

      rule(:text) { ::Template::Text::Parser.new }
      rule(:code) { ::Template::Code::Parser.new }

      rule(:part) { text | (left_curly_brace >> code >> right_curly_brace) }
      root(:part)
    end
  end
end
