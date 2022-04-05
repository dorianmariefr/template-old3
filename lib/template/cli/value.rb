class Template
  class Cli < Thor
    class Value < Generic
      def self.base
        ::Template::Value
      end
    end
  end
end
