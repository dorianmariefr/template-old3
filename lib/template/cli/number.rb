class Template
  class Cli < Thor
    class Number < Generic
      def self.base
        ::Template::Number
      end
    end
  end
end
