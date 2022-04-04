class Template
  class Cli < Thor
    class Dictionnary < Generic
      def self.key
        :dictionnary
      end

      def self.base
        ::Template::Dictionnary
      end

      def self.parser
        ::Template::Dictionnary::Parser
      end
    end
  end
end
