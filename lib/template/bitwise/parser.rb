class Template
  class Bitwise < Node
    class Parser < Parslet::Parser
      rule(:plus) { ::Template::Plus::Parser.new }
      rule(:bitwise) { plus }
      root(:bitwise)
    end
  end
end
