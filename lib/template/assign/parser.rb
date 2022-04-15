class Template
  class Assign < Node
    class Parser < Parslet::Parser
      rule(:rescue_statement) { ::Template::Rescue::Parser.new }

      rule(:equal) { str("=") }
      rule(:plus_equal) { str("+=") }
      rule(:minus_equal) { str("-=") }
      rule(:times_equal) { str("*=") }
      rule(:times_times_equal) { str("**=") }
      rule(:slash_equal) { str("/=") }
      rule(:percent_equal) { str("%=") }
      rule(:less_than_less_than_equal) { str("<<=") }
      rule(:more_than_more_than_equal) { str(">>=") }
      rule(:ampersand_equal) { str("&=") }
      rule(:ampersand_ampersand_equal) { str("&&=") }
      rule(:pipe_equal) { str("|=") }
      rule(:pipe_pipe_equal) { str("||=") }
      rule(:caret_equal) { str("^=") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) do
        equal | plus_equal | minus_equal | times_equal | times_times_equal |
          slash_equal | percent_equal | less_than_less_than_equal |
          more_than_more_than_equal | ampersand_equal |
          ampersand_ampersand_equal | pipe_equal | pipe_pipe_equal | caret_equal
      end

      rule(:assign) do
        (
          rescue_statement.as(:left) >> spaces? >> operator.as(:operator) >>
            spaces? >> assign.as(:right)
        ).as(:assign) | rescue_statement
      end
      root(:assign)
    end
  end
end
