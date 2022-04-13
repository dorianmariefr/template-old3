class Template
  class Code < Node
    class Parser < Parslet::Parser
      rule(:statement) { ::Template::Statement::Parser.new }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:code) { (spaces? >> statement >> spaces?).repeat(1).as(:code) }
      root(:code)
    end
  end
end
