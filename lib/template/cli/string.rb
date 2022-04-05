class Template
  class Cli < Thor
    class String < Generic
      def self.base
        ::Template::String
      end
    end
  end
end
