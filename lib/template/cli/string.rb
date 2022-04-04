class Template
  class Cli < Thor
    class String < Generic
      def self.key
        :string
      end

      def self.base
        ::Template::String
      end

      def self.parser
        ::Template::String::Parser
      end
    end
  end
end
