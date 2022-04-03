class Template
  class Bin
    class Evaluate
      MIN = 1
      MAX = 2
      TRACE = "--trace"

      def initialize(name:, evaluator:, parser:, argv:)
        @name = name
        @evaluator = evaluator
        @parser = parser
        @argv = argv
      end

      def evaluate
        pp evaluator.new(parse).evaluate
      end

      private

      def parse
        if argv.size < MIN || argv.size > MAX
          usage
        elsif argv[1] && argv[1] != TRACE
          usage
        else
          begin
            parser.new.parse(source)
          rescue Parslet::ParseFailed => error
            Template::Bin::Error.print(error, trace: trace?)
            abort
          end
        end
      end

      attr_reader :name, :evaluator, :parser, :argv

      def usage
        puts "USAGE: bin/#{name}/evaluator INPUT [#{TRACE}]"
        abort
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