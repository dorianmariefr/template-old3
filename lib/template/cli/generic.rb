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

      desc "parse SOURCE", "parses source into ruby hash"
      option :verbose, type: :boolean, default: false, aliases: "-v"
      def parse(source)
        pp self.class.parse(source, options)
      end

      desc(
        "render SOURCE",
        "renders source with optional context"
      )
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: nil, aliases: "-c"
      def render(source)
        parsed = self.class.parse(source, options)
        parsed = parsed.fetch(key) if self.class.key

        if options.context
          context = ::Template::Value.new(
            self.class.parse(options.context, options)
          ).evaluate
          print self.class.base.new(parsed).render(context)
        else
          print self.class.base.new(parsed).render
        end

        puts
      end
    end
  end
end
