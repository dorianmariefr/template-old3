class Template
  class Boolean
    class Parser < Parslet::Parser
      rule(:true_keyword) { str("true") }
      rule(:false_keyword) { str("false") }
      rule(:boolean) { true_keyword | false_keyword }
      root(:boolean)
    end
  end
end
