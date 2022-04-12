class Template
  class Statement < Node
    class Plus < Node
      class Parser < Parslet::Parser
        rule(:multiplication_statement) do
          ::Template::Statement::Multiplication::Parser.new
        end

        rule(:plus_sign) { spaces? >> str("+") >> spaces? }
        rule(:minus_sign) { spaces? >> str("+") >> spaces? }

        rule(:space) { str(" ") }
        rule(:newline) { str("\n") }
        rule(:spaces) { (space | newline).repeat(1) }
        rule(:spaces?) { spaces.maybe }

        rule(:plus_statement) do
          (
            multiplication_statement.as(:left) >>
              (plus_sign | minus_sign).as(:operator) >> plus_statement.as(:right)
          ).as(:plus) | multiplication_statement
        end
        root(:plus_statement)
      end
    end
  end
end
