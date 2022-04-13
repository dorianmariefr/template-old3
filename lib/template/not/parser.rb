class Template
  class Not < Node
    class Parser < Parslet::Parser
      rule(:assign_statement) { ::Template::Assign::Parser.new }

      rule(:not_keyword) { str("not") }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:not_statement) do
        (not_keyword >> spaces? >> assign_statement).as(:not) | assign_statement
      end
      root(:not_statement)
    end
  end
end
