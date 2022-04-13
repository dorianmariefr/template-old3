class Template
  class String < Node
    class Parser < Parslet::Parser
      rule(:single_quote) { str("'") }
      rule(:double_quote) { str("\"") }
      rule(:backslash) { str('\\') }
      rule(:n) { str("n") }
      rule(:escaped_character) do
        backslash >> (n | single_quote | double_quote)
      end
      rule(:single_quoted_character) do
        escaped_character | (single_quote.absent? >> backslash.absent? >> any)
      end
      rule(:double_quoted_character) do
        escaped_character | (double_quote.absent? >> backslash.absent? >> any)
      end
      rule(:single_quoted_string) do
        single_quote.ignore >> single_quoted_character.repeat(0) >>
          single_quote.ignore
      end
      rule(:double_quoted_string) do
        double_quote.ignore >> double_quoted_character.repeat(0) >>
          double_quote.ignore
      end
      rule(:string) do
        (single_quoted_string | double_quoted_string).as(:string)
      end
      root(:string)
    end
  end
end
