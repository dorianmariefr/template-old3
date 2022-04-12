class Template
  class Statement < Node
    class Parser < Parslet::Parser
      rule(:plus_statement) { ::Template::Statement::Plus::Parser.new }
      rule(:implicit_dictionnary) { ::Template::ImplicitDictionnary::Parser.new }
      rule(:implicit_list) { ::Template::ImplicitList::Parser.new }

      rule(:statement) do
        implicit_dictionnary.as(:value) | implicit_list.as(:value) | plus_statement
      end
      root(:statement)
    end
  end
end
