class Template
  class Cli < Thor
    class Nothing < Generic
      def self.base
        ::Template::Nothing
      end
    end
  end
end
