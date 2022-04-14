class Template
  class Comparaison < Node
    class Parser < Parslet::Parser
      rule(:bitwise) { ::Template::Bitwise::Parser.new }
      rule(:comparaison) do
        bitwise
      end
      root(:comparaison)
    end
  end
end
