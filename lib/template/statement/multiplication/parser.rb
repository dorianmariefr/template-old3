class Template
  class Statement < Node
    class Multiplication < Node
      class Parser < Parslet::Parser
        rule(:value_statement) { ::Template::Statement::Value::Parser.new }

        rule(:multiplication_sign) { str("*") }
        rule(:division_sign) { str("/") }

        rule(:space) { str(" ") }
        rule(:newline) { str("\n") }
        rule(:spaces) { (space | newline).repeat(1) }
        rule(:spaces?) { spaces.maybe }

        rule(:multiplication_statement) do
          (
            value_statement.as(:left) >>
              (
                  spaces? >>
                    (multiplication_sign | division_sign).as(:operator) >>
                    spaces? >> value_statement.as(:right)
                )
                .repeat(1)
                .as(:right)
          ).as(:multiplication) | value_statement
        end
        root(:multiplication_statement)
      end
    end
  end
end
