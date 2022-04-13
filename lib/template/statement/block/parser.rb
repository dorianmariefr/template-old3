class Template
  class Statement < Node
    class Block < Node
      class Parser < Parslet::Parser
        rule(:value_statement) { ::Template::Statement::Value::Parser.new }
        rule(:code) { ::Template::Code::Parser.new }

        rule(:left_curly_bracket) { str("{") }
        rule(:right_curly_bracket) { str("}") }

        rule(:space) { str(" ") }
        rule(:newline) { str("\n") }
        rule(:spaces) { (space | newline).repeat(1) }
        rule(:spaces?) { spaces.maybe }

        rule(:block_statement) do
          (
            (value_statement.as(:left) >> spaces?).maybe >>
              left_curly_bracket >> spaces? >> code.as(:body) >> spaces? >>
              right_curly_bracket
          ).as(:block) | value_statement
        end

        root(:block_statement)
      end
    end
  end
end
