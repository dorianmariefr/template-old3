require_relative "cli/generic"

require_relative "cli/boolean"
require_relative "cli/call"
require_relative "cli/dictionnary"
require_relative "cli/list"
require_relative "cli/nothing"
require_relative "cli/number"
require_relative "cli/string"
require_relative "cli/value"

class Template
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    desc "nothing SUBCOMMAND ..ARGS", "nothings's language"
    subcommand :nothing, Template::Cli::Nothing

    desc "boolean SUBCOMMAND ..ARGS", "boolean's language"
    subcommand :boolean, Template::Cli::Boolean

    desc "string SUBCOMMAND ..ARGS", "string's language"
    subcommand :string, Template::Cli::String

    desc "number SUBCOMMAND ..ARGS", "number's language"
    subcommand :number, Template::Cli::Number

    desc "list SUBCOMMAND ..ARGS", "list's language"
    subcommand :list, Template::Cli::List

    desc "dictionnary SUBCOMMAND ..ARGS", "list's language"
    subcommand :dictionnary, Template::Cli::Dictionnary

    desc "call SUBCOMMAND ..ARGS", "call's language"
    subcommand :call, Template::Cli::Call

    desc "value SUBCOMMAND ..ARGS", "value's language"
    subcommand :value, Template::Cli::Value
  end
end
