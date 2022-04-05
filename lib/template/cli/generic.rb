class Template
  class Cli < Thor
    class Generic < Thor
      def self.base
        raise NotImplementedError
      end

      desc "parse SOURCE", "parses source into ruby hash"
      option :verbose, type: :boolean, default: false, aliases: "-v"
      def parse(source)
        pp self.class.base.parse(source, options)
      rescue ::Template::Error => error
        $stderr.puts error.message
        exit 1
      end

      desc(
        "render SOURCE",
        "renders source with optional context"
      )
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: nil, aliases: "-c"
      def render(source)
        print self.class.base.render(source, options)
        puts
      rescue ::Template::Error => error
        $stderr.puts error.message
        exit 1
      end
    end
  end
end
