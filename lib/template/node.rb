class Template
  class Node
    def initialize(parsed)
      raise NotImplementedError, self.class.name
    end

    def self.parser
      raise NotImplementedError
    end

    def self.key
      raise NotImplementedError
    end

    def self.parse(source, options = {})
      parser.new.parse(source)
    rescue ::Parslet::ParseFailed => error
      raise(
        ::Template::Error,
        ::Template::Error::Message.from_exception(error, verbose: !!options[:verbose])
      )
    end

    def self.evaluate(source, options = {})
      parsed = parse(source, { verbose: options[:verbose] })
      parsed = parsed.fetch(key) if key
      if options[:context]
        context = ::Template::Code.evaluate(
          options[:context],
          { verbose: options[:verbose] }
        )
        new(parsed).evaluate(context)
      else
        new(parsed).evaluate
      end
    end

    def self.render(source, options = {})
      parsed = parse(source, { verbose: options[:verbose] })
      parsed = parsed.fetch(key) if key

      if options[:context]
        context = ::Template::Code.evaluate(
          options[:context],
          { verbose: options[:verbose] }
        )
        new(parsed).render(context)
      else
        new(parsed).render
      end
    end

    def default_context
      ::Template::Dictionnary.empty
    end

    def evaluate(_context = default_context)
      raise NotImplementedError
    end

    def render(_context = default_context)
      raise NotImplementedError
    end

    def equal?(other)
      raise NotImplementedError
    end

    def fetch(*args)
      raise ArgumentError if args.size < 1 || args.size > 2
      ::Template::Nothing.nothing
    end
  end
end
