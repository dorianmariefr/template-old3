class Template
  class Cli < Thor
    class List < Generic
      def self.key
        :list
      end

      def self.base
        ::Template::List
      end

      def self.parser
        ::Template::List::Parser
      end
    end
  end
end
