class Template
  class Part < Node
    class Parser < Parslet::Parser
      rule(:text) { ::Template::Text::Parser.new }
      rule(:code) { ::Template::Code::Parser.new }

      rule(:left_curly_brace) { str("{") }
      rule(:right_curly_brace) { str("}") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:part) do
        text |
          (left_curly_brace >> spaces? >> code >> spaces? >> right_curly_brace)
      end
      root(:part)
    end
  end
end
