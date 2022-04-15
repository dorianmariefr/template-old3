class Template
  class Comparaison < Node
    class Parser < Parslet::Parser
      rule(:bitwise) { ::Template::Bitwise::Parser.new }

      rule(:equal_equal) { str("==") }
      rule(:equal_equal_equal) { str("===") }
      rule(:tilde_equal) { str("~=") }
      rule(:equal_tilde) { str("=~") }
      rule(:tilde_exclamation_point) { str("~!") }
      rule(:exclamation_point_tilde) { str("!~") }
      rule(:exclamation_point_equal) { str("!=") }
      rule(:less_than) { str("<") }
      rule(:more_than) { str(">") }
      rule(:less_than_equal) { str("<=") }
      rule(:more_than_equal) { str(">=") }
      rule(:less_than_equal_more_than) { str("<=>") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) do
        equal_equal_equal | equal_equal | tilde_equal | equal_tilde |
          tilde_exclamation_point | exclamation_point_tilde |
          exclamation_point_equal | less_than_equal_more_than |
          less_than_equal | more_than_equal | less_than | more_than
      end

      rule(:comparaison) do
        (
          bitwise.as(:left) >> spaces? >> operator.as(:operator) >> spaces? >>
            bitwise.as(:right)
        ).as(:comparaison) | bitwise
      end
      root(:comparaison)
    end
  end
end
