class Template
  class Cli < Thor
    class Boolean < Generic
      def self.key
        :boolean
      end

      def self.base
        ::Template::Boolean
      end

      def self.parser
        ::Template::Boolean::Parser
      end
    end
  end
end
