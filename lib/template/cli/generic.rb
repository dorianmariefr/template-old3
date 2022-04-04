class Template
  class Cli < Thor
    class Generic < Thor
      def self.parse(source, options)
        parser.new.parse(source)
      rescue ::Parslet::ParseFailed => error
        ::Template::Parser::Error.print(error, trace: options.verbose?)
        exit 1
      end

      def self.transform(source, options)
        base.new(parse(source, options).fetch(key))
      end

      desc "parse SOURCE", "parses source into ruby hash"
      option :verbose, type: :boolean, default: false, aliases: "-v"
      def parse(source)
        pp self.class.parse(source, options)
      end
      map "p" => :parse
      map "pa" => :parse

      desc(
        "evaluate SOURCE",
        "evaluates source with optional context"
      )
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: "", aliases: "-c"
      def evaluate(source)
        pp self.class.transform(source, options).evaluate
      end
      map "e" => :evaluate
      map "ev" => :evaluate
      map "eval" => :evaluate

      desc(
        "render SOURCE",
        "renders source with optional context"
      )
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: "", aliases: "-c"
      def render(source)
        puts self.class.transform(source, options).render
      end
      map "r" => :render
      map "re" => :render
    end
  end
end
