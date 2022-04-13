class Template
  class Multiplication < Node
    class Parser < Parslet::Parser
      rule(:value) { ::Template::Value::Parser.new }

      rule(:multiplication_sign) { str("*") }
      rule(:division_sign) { str("/") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:multiplication) do
        (
          value.as(:first) >>
            (
                spaces? >>
                  (multiplication_sign | division_sign).as(:operator) >>
                  spaces? >> value.as(:other)
              )
              .repeat(1)
              .as(:others)
        ).as(:multiplication) | value
      end
      root(:multiplication)
    end
  end
end
