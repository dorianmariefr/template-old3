class Template
  class Cli < Thor
    class Generic < Thor
      def self.key
        raise NotImplementedError
      end

      def self.base
        raise NotImplementedError
      end

      def self.parser
        raise NotImplementedError
      end

      def self.parse(source, options)
        parser.new.parse(source)
      rescue ::Parslet::ParseFailed => error
        ::Template::Parser::Error.print(error, trace: options.verbose?)
        exit 1
      end

      def self.transform(source, options)
        parsed = parse(source, options)
        parsed = parsed.fetch(key) if key
        base.new(parsed)
      end

      desc "parse SOURCE", "parses source into ruby hash"
      option :verbose, type: :boolean, default: false, aliases: "-v"
      def parse(source)
        pp self.class.parse(source, options)
      end

      desc(
        "evaluate SOURCE",
        "evaluates source with optional context"
      )
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: "", aliases: "-c"
      def evaluate(source)
        pp self.class.transform(source, options).evaluate
      end

      desc(
        "render SOURCE",
        "renders source with optional context"
      )
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: "", aliases: "-c"
      def render(source)
        print self.class.transform(source, options).render
        puts
      end
    end
  end
end
