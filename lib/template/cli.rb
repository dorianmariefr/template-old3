require_relative "cli/generic"

require_relative "cli/boolean"
require_relative "cli/call"
require_relative "cli/code"
require_relative "cli/dictionnary"
require_relative "cli/list"
require_relative "cli/nothing"
require_relative "cli/number"
require_relative "cli/statement"
require_relative "cli/string"
require_relative "cli/template"
require_relative "cli/value"

class Template
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    desc "parse SOURCE", "parses source into ruby hash"
    option :verbose, type: :boolean, default: false, aliases: "-v"
    def parse(*sources)
      sources.each do |source|
        source = File.read(source) if File.exists?(source)
        pp ::Template::Template.parse(source, verbose: options[:verbose])
      rescue ::Template::Error => error
        $stderr.puts error.message
        exit 1
      end
    end

    desc(
      "render SOURCE",
      "renders source with optional context"
    )
    option :verbose, type: :boolean, default: false, aliases: "-v"
    option :context, type: :string, default: nil, aliases: "-c"
    def render(*sources)
      context = options[:context]

      if context && File.exists?(context)
        context = File.read(context).gsub(/\n$/, '')
      end

      sources.each do |source|
        source = File.read(source) if File.exists?(source)
        puts ::Template::Template.render(
          source, context: context, verbose: options[:verbose]
        )
      rescue ::Template::Error => error
        $stderr.puts error.message
        exit 1
      end
    end

    desc "nothing SUBCOMMAND ..ARGS", "nothings's language"
    subcommand :nothing, ::Template::Cli::Nothing

    desc "boolean SUBCOMMAND ..ARGS", "boolean's language"
    subcommand :boolean, ::Template::Cli::Boolean

    desc "string SUBCOMMAND ..ARGS", "string's language"
    subcommand :string, ::Template::Cli::String

    desc "number SUBCOMMAND ..ARGS", "number's language"
    subcommand :number, ::Template::Cli::Number

    desc "list SUBCOMMAND ..ARGS", "list's language"
    subcommand :list, ::Template::Cli::List

    desc "dictionnary SUBCOMMAND ..ARGS", "list's language"
    subcommand :dictionnary, ::Template::Cli::Dictionnary

    desc "call SUBCOMMAND ..ARGS", "call's language"
    subcommand :call, ::Template::Cli::Call

    desc "value SUBCOMMAND ..ARGS", "value's language"
    subcommand :value, ::Template::Cli::Value

    desc "template SUBCOMMAND ..ARGS", "template's language"
    subcommand :template, ::Template::Cli::Template

    desc "code SUBCOMMAND ..ARGS", "code's language"
    subcommand :code, ::Template::Cli::Code

    desc "statement SUBCOMMAND ..ARGS", "statement's language"
    subcommand :statement, ::Template::Cli::Statement
  end
end
