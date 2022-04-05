class Template
  class Boolean < Node
    class Parser < Parslet::Parser
      rule(:true_keyword) { str("true") }
      rule(:false_keyword) { str("false") }
      rule(:boolean) { (true_keyword | false_keyword).as(:boolean) }
      root(:boolean)
    end
  end
end
