class Template
  class Statement < Node
    class Multiplication < Node
      class Parser < Parslet::Parser
        rule(:call_statement) { ::Template::Statement::Call::Parser.new }

        rule(:multiplication_sign) { spaces? >> str("*") >> spaces? }
        rule(:division_sign) { spaces? >> str("/") >> spaces? }

        rule(:space) { str(" ") }
        rule(:newline) { str("\n") }
        rule(:spaces) { (space | newline).repeat(1) }
        rule(:spaces?) { spaces.maybe }

        rule(:multiplication_statement) do
          (
            call_statement.as(:left) >>
              (multiplication_sign | division_sign).as(:operator) >>
              multiplication_statement.as(:right)
          ).as(:multiplication) | call_statement
        end
        root(:multiplication_statement)
      end
    end
  end
end
