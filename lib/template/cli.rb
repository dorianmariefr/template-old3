require_relative "cli/generic"

require_relative "cli/nothing"
require_relative "cli/boolean"
require_relative "cli/string"
require_relative "cli/number"

class Template
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    desc "nothing SUBCOMMAND ..ARGS", "nothings's language"
    subcommand :nothing, Template::Cli::Nothing
    map "no" => :nothing

    desc "boolean SUBCOMMAND ..ARGS", "boolean's language"
    subcommand :boolean, Template::Cli::Boolean
    map "b" => :boolean
    map "bo" => :boolean

    desc "string SUBCOMMAND ..ARGS", "string's language"
    subcommand :string, Template::Cli::String
    map "s" => :string
    map "st" => :string

    desc "number SUBCOMMAND ..ARGS", "number's language"
    subcommand :number, Template::Cli::Number
    map "nu" => :number
  end
end
