class Template
  class Cli < Thor
    class Generic < Thor
      def self.base
        raise NotImplementedError
      end

      desc "parse SOURCE", "parses source into ruby hash"
      option :verbose, type: :boolean, default: false, aliases: "-v"
      def parse(*sources)
        sources.each do |source|
          source = File.read(source).gsub(/\n$/, "") if File.exists?(source)
          pp self.class.base.parse(source, verbose: options[:verbose])
        rescue ::Template::Error => error
          $stderr.puts error.message
          exit 1
        end
      end

      desc("render SOURCE", "renders source with optional context")
      option :verbose, type: :boolean, default: false, aliases: "-v"
      option :context, type: :string, default: nil, aliases: "-c"
      def render(*sources)
        context = options[:context]

        if context && File.exists?(context)
          context = File.read(context).gsub(/\n$/, "")
        end

        sources.each do |source|
          source = File.read(source).gsub(/\n$/, "") if File.exists?(source)
          puts self.class.base.render(
                 source,
                 context: context,
                 verbose: options[:verbose]
               )
        rescue ::Template::Error => error
          $stderr.puts error.message
          exit 1
        end
      end
    end
  end
end
