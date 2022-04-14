class Template
  class Ternary < Node
    class Parser < Parslet::Parser
      rule(:range) { ::Template::Range::Parser.new }

      rule(:question_mark) { str("?") }
      rule(:colon) { str(":") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:ternary_statement) do
        (
          range.as(:left) >> spaces >> question_mark >> spaces? >>
            range.as(:middle) >> spaces? >> colon >> spaces? >> range.as(:right) |
          range.as(:left) >> spaces >> question_mark >> spaces? >>
            range.as(:middle)
        ).as(:ternary) | range
      end
      root(:ternary_statement)
    end
  end
end
