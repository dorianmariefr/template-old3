class Template
  class Cli < Thor
    class Statement < Generic
      def self.base
        ::Template::Statement
      end
    end
  end
end
