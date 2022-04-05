class Template
  class Cli < Thor
    class Call < Generic
      def self.base
        ::Template::Call
      end
    end
  end
end
