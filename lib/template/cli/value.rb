class Template
  class Cli < Thor
    class Value < Generic
      def self.key
        nil
      end

      def self.base
        ::Template::Value
      end

      def self.parser
        ::Template::Value::Parser
      end
    end
  end
end
