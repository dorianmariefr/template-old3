class Template
  class Modifier < Node
    class Parser < Parslet::Parser
      rule(:block_statement) { ::Template::Block::Parser.new }

      rule(:if_keyword) { str("if") }
      rule(:unless_keyword) { str("unless") }
      rule(:while_keyword) { str("while") }
      rule(:until_keyword) { str("until") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:keyword) do
        if_keyword | unless_keyword | while_keyword | until_keyword
      end

      rule(:modifier) do
        (
          block_statement.as(:body) >> spaces? >> keyword.as(:keyword) >>
            spaces? >> modifier.as(:condition)
        ).as(:modifier) | block_statement
      end

      root(:modifier)
    end
  end
end
