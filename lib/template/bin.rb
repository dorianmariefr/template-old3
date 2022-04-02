require_relative "bin/parse"
require_relative "bin/error"

class Template
  class Bin
    def self.parse(name:, parser:, argv:)
      Template::Bin::Parse.new(name: name, parser: parser, argv: argv).parse
    end
  end
end
