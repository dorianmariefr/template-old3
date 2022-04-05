class Template
  class Nothing < Node
    class Parser < Parslet::Parser
      rule(:nothing_keyword) { str("nothing") }
      rule(:nothing) { nothing_keyword.as(:nothing) }
      root(:nothing)
    end
  end
end
