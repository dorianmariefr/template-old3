class Template
  class Cli < Thor
    class List < Generic
      def self.base
        ::Template::List
      end
    end
  end
end
