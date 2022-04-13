class Template
  class Statement < Node
    class Modifier < Node
      class Parser < Parslet::Parser
        rule(:or_statement) { ::Template::Statement::Value::Parser.new }

        rule(:if_keyword) { str("if") }
        rule(:unless_keyword) { str("unless") }
        rule(:while_keyword) { str("while") }
        rule(:until_keyword) { str("until") }

        rule(:space) { str(" ") }
        rule(:newline) { str("\n") }
        rule(:spaces) { (space | newline).repeat(1) }

        rule(:keyword) do
          if_keyword | unless_keyword | while_keyword | until_keyword
        end

        rule(:modifier_statement) do
          (
            or_statement.as(:body) >> spaces >> keyword.as(:keyword) >>
              spaces >> modifier_statement.as(:condition)
          ).as(:modifier) | or_statement
        end

        root(:modifier_statement)
      end
    end
  end
end
