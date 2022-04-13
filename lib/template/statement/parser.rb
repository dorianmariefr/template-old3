class Template
  class Statement < Node
    class Parser < Parslet::Parser
      rule(:modifier_statement) { ::Template::Modifier::Parser.new }
      rule(:implicit_dictionnary) do
        ::Template::ImplicitDictionnary::Parser.new
      end
      rule(:implicit_list) { ::Template::ImplicitList::Parser.new }

      rule(:statement) do
        implicit_dictionnary.as(:value) | implicit_list.as(:value) |
          modifier_statement
      end
      root(:statement)
    end
  end
end
