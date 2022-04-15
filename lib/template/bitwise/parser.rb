class Template
  class Bitwise < Node
    class Parser < Parslet::Parser
      rule(:plus) { ::Template::Plus::Parser.new }

      rule(:pipe) { str("|") }
      rule(:caret) { str("^") }
      rule(:ampersand) { str("&") }
      rule(:less_than_less_than) { str("<<") }
      rule(:more_than_more_than) { str(">>") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) do
        pipe | caret | ampersand | less_than_less_than | more_than_more_than
      end

      rule(:bitwise) do
        (
          plus.as(:left) >> spaces? >> operator.as(:operator) >> spaces? >>
            plus.as(:right)
        ).as(:bitwise) | plus
      end
      root(:bitwise)
    end
  end
end
