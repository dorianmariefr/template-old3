class Template
  class And < Node
    class Parser < Parslet::Parser
      rule(:not_statement) { ::Template::Not::Parser.new }

      rule(:and_keyword) { str("and") }
      rule(:or_keyword) { str("or") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:keyword) { and_keyword | or_keyword }

      rule(:and_statement) do
        (
          not_statement.as(:left) >> spaces? >> keyword.as(:keyword) >> spaces? >> not_statement.as(:right)
        ).as(:and) | not_statement
      end
      root(:and_statement)
    end
  end
end
