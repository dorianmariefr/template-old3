class Template
  class Range < Node
    class Parser < Parslet::Parser
      rule(:short_and) { ::Template::ShortAnd::Parser.new }

      rule(:dot_dot) { str("..") }
      rule(:dot_dot_dot) { str("...") }

      rule(:operator) { dot_dot_dot | dot_dot }

      rule(:range) do
        (
          short_and.as(:left) >> operator >> short_and.as(:right) |
          operator >> short_and.as(:right) |
          short_and.as(:left) >> operator
        ).as(:range) | short_and
      end
      root(:range)
    end
  end
end
