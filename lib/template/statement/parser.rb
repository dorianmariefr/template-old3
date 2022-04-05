class Template
  class Statement < Node
    class Parser < Parslet::Parser
      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }
      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { spaces.maybe }
      rule(:value) { ::Template::Value::Parser.new }
      rule(:statement) { spaces? >> value.as(:value) >> spaces? }
      root(:statement)
    end
  end
end
