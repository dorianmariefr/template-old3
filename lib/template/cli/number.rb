class Template
  class Cli < Thor
    class Number < Generic
      def self.key
        :number
      end

      def self.base
        ::Template::Number
      end

      def self.parser
        ::Template::Number::Parser
      end
    end
  end
end
