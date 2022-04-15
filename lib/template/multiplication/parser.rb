class Template
  class Multiplication < Node
    class Parser < Parslet::Parser
      rule(:power) { ::Template::Power::Parser.new }

      rule(:times) { str("*") }
      rule(:slash) { str("/") }
      rule(:percent) { str("%") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) { times | slash | percent }

      rule(:multiplication) do
        (
          power.as(:first) >>
            (spaces? >> operator.as(:operator) >> spaces? >> power.as(:other))
              .repeat(1)
              .as(:others)
        ).as(:multiplication) | power
      end
      root(:multiplication)
    end
  end
end
