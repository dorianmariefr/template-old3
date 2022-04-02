class Template
  class String
    class Parser < Parslet::Parser
      rule(:single_quote) { str("'") }
      rule(:double_quote) { str('"') }
      rule(:backslash) { str('\\') }
      rule(:single_quoted_character) do
        (backslash >> any) | (single_quote.absent? >> any)
      end
      rule(:double_quoted_character) do
        (backslash >> any) | (double_quote.absent? >> any)
      end
      rule(:single_quoted_string) do
        single_quote.ignore >> single_quoted_character.repeat(0) >> single_quote.ignore
      end
      rule(:double_quoted_string) do
        double_quote.ignore >> double_quoted_character.repeat(0) >> double_quote.ignore
      end
      rule(:string) { (single_quoted_string | double_quoted_string).as(:string) }
      root(:string)
    end
  end
end
