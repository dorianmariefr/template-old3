class Template
  class Cli < Thor
    class Template < Generic
      def self.base
        ::Template::Template
      end
    end
  end
end
