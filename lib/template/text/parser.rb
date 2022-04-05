class Template
  class Text < Node
    class Parser < Parslet::Parser
      rule(:backslash) { str("\\") }
      rule(:left_curly_bracket) { str("{") }

      rule(:escaped) { backslash.ignore >> left_curly_bracket }
      rule(:non_escaped) { left_curly_bracket.absent? >> any }

      rule(:character) { escaped | non_escaped }

      rule(:text) { character.repeat(1).as(:text) }
      root(:text)
    end
  end
end
