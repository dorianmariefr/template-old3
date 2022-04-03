# typed: false
class Template
  class Code
    class Parser < Parslet::Parser
      rule(:value) { Template::Value::Parser.new }

      rule(:space) { str(" ") }
      rule(:newline) { str("\n") }

      rule(:spaces) { (space | newline).repeat(1) }
      rule(:spaces?) { (comment | spaces.ignore).maybe }

      rule(:value_statement) { value }
      rule(:statement) { value_statement }

      rule(:code) { statement.repeat(1).as(:code) }
      root(:code)
    end
  end
end
