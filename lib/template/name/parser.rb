class Template
  class Name
    class Parser < Parslet::Parser
      rule(:single_quote) { str("'") }
      rule(:double_quote) { str("\"") }
      rule(:backslash) { str('\\') }
      rule(:left_square_bracket) { str("[") }
      rule(:right_square_bracket) { str("]") }
      rule(:left_curly_bracket) { str("{") }
      rule(:right_curly_bracket) { str("}") }
      rule(:comma) { str(",") }
      rule(:colon) { str(":") }
      rule(:equal) { str("=") }
      rule(:left_carret) { str("<") }
      rule(:right_carret) { str(">") }
      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }

      rule(:nothing_keyword) { str("nothing") }
      rule(:true_keyword) { str("true") }
      rule(:false_keyword) { str("false") }

      rule(:special_character) do
        single_quote | double_quote | backslash | left_square_bracket |
          right_square_bracket | left_curly_bracket | right_curly_bracket |
          comma | colon | equal | left_carret | right_carret | space | newline
      end

      rule(:keyword) { nothing_keyword | true_keyword | false_keyword }

      rule(:name_character) { special_character.absent? >> any }

      rule(:name) { keyword.absent? >> name_character.repeat(1) }
      root(:name)
    end
  end
end
