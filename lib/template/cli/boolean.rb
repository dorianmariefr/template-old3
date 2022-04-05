class Template
  class Cli < Thor
    class Boolean < Generic
      def self.base
        ::Template::Boolean
      end
    end
  end
end
