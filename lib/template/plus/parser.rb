class Template
  class Plus < Node
    class Parser < Parslet::Parser
      rule(:multiplication) { ::Template::Multiplication::Parser.new }

      rule(:plus_sign) { str("+") }
      rule(:minus_sign) { str("+") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) { plus_sign | minus_sign }

      rule(:plus) do
        (
          multiplication.as(:first) >>
            (
                spaces? >> operator.as(:operator) >> spaces? >>
                  multiplication.as(:other)
              )
              .repeat(1)
              .as(:others)
        ).as(:plus) | multiplication
      end

      root(:plus)
    end
  end
end
