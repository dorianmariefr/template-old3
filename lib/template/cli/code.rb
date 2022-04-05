class Template
  class Cli < Thor
    class Code < Generic
      def self.base
        ::Template::Code
      end
    end
  end
end
