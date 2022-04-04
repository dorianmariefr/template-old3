class Template
  class Cli < Thor
    class Nothing < Generic
      def self.key
        :nothing
      end

      def self.base
        ::Template::Nothing
      end

      def self.parser
        ::Template::Nothing::Parser
      end
    end
  end
end
