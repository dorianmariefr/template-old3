class Template
  class Nothing
    class Parser < Parslet::Parser
      rule(:nothing) { str("nothing").as(:nothing) }
      root(:nothing)
    end
  end
end
