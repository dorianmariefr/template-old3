class Template
  class ShortAnd < Node
    class Parser < Parslet::Parser
      rule(:comparaison) { ::Template::Comparaison::Parser.new }

      rule(:pipe_pipe) { str("||") }
      rule(:ampersand_ampersand) { str("&&") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:operator) { pipe_pipe | ampersand_ampersand }

      rule(:short_and) do
        (
          comparaison.as(:left) >> spaces? >> operator.as(:operator) >> spaces? >> comparaison.as(:right)
        ).as(:short_and) | comparaison
      end
      root(:short_and)
    end
  end
end
