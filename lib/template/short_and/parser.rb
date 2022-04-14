class Template
  class ShortAnd < Node
    class Parser < Parslet::Parser
      rule(:comparaison) { ::Template::Comparaison::Parser.new }
      rule(:short_and) do
        comparaison
      end
      root(:short_and)
    end
  end
end
