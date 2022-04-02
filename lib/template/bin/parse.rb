class Template
  class Bin
    class Parse
      MIN = 1
      MAX = 2
      TRACE = "--trace"

      def initialize(name:, parser:, argv:)
        @name = name
        @parser = parser
        @argv = argv
      end

      def parse
        if argv.size < MIN || argv.size > MAX
          usage
        elsif argv[1] && argv[1] != TRACE
          usage
        else
          begin
            pp parser.new.parse(source)
          rescue Parslet::ParseFailed => error
            Template::Bin::Error.print(error, trace: trace?)
          end
        end
      end

      private

      attr_reader :name, :parser, :argv

      def usage
        puts "USAGE: bin/#{name}/parse INPUT [#{TRACE}]"
      end

      def source
        File.exists?(argv[0]) ? File.read(argv[0]) : argv[0]
      end

      def trace?
        argv[1] == TRACE
      end
    end
  end
end
