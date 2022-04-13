class Template
  class Block < Node
    class Parser < Parslet::Parser
      rule(:and_statement) { ::Template::And::Parser.new }
      rule(:code) { ::Template::Code::Parser.new }

      rule(:left_curly_bracket) { str("{") }
      rule(:right_curly_bracket) { str("}") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:block_statement) do
        (
          (and_statement.as(:left) >> spaces?).maybe >>
          (
            left_curly_bracket >> spaces? >> code.as(:body).maybe >> spaces? >>
              right_curly_bracket
          ).as(:first) >>
          (
            spaces? >> left_curly_bracket >> spaces? >> code.as(:body).maybe >> spaces? >>
              right_curly_bracket
          ).repeat(1).as(:others).maybe
        ).as(:block) | and_statement
      end

      root(:block_statement)
    end
  end
end
