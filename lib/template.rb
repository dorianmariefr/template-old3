require "bigdecimal/util"
require "parslet"
require "thor"
require "memo_wise"

require_relative "template/node"

# value
require_relative "template/boolean" # true
require_relative "template/dictionnary" # { a: 1, b: 2 }
require_relative "template/implicit_dictionnary" # a: 1, b: 2
require_relative "template/implicit_list" # a, b, c
require_relative "template/key_value" # a: 1
require_relative "template/list" # [a, b, c]
require_relative "template/name" # a
require_relative "template/nothing" # nothing
require_relative "template/number" # 1
require_relative "template/string" # "hello"

# code
require_relative "template/code" # a.b c.d
require_relative "template/statement" # a + b

# statements
require_relative "template/modifier" # a { b } unless  c { d }
require_relative "template/block" # a or b { c or d }
require_relative "template/and" # not a or not b
require_relative "template/not" # b = not a
require_relative "template/assign" # a = b rescue c
require_relative "template/rescue" # a ? b : c rescue d
require_relative "template/ternary" # a ? b..c : c..d
require_relative "template/range" # b||c..d&&e
require_relative "template/short_and" # a == b || c != d && e =~ f
require_relative "template/comparaison" # a | b == c << d
require_relative "template/bitwise" # a + b << c - d
require_relative "template/plus" # a * b + c / d
require_relative "template/multiplication" # a ** b * c ** d
require_relative "template/power" # -a**-b
require_relative "template/unary" # -1
require_relative "template/value" # 1.a
require_relative "template/call" # a.b

# template
require_relative "template/part" # Hello, name
require_relative "template/text" # Hello
require_relative "template/template" # Hello {name}

require_relative "template/error"

require_relative "template/cli"

class Template
end
