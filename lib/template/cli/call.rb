class Template
  class Cli < Thor
    class Call < Generic
      def self.key
        :call
      end

      def self.base
        ::Template::Call
      end

      def self.parser
        ::Template::Call::Parser
      end
    end
  end
end
