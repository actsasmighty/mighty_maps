module MightyMaps
  module Types
    class SeatMap
      attr_accessor :blocks
      attr_accessor :name
      attr_accessor :x
      attr_accessor :y

      def initialize(options = {})
        self.blocks = options[:blocks] || options["blocks"] || []
        self.name = options[:name] || options["name"]
        self.x = options[:x] || options["x"] || 0
        self.y = options[:y] || options["y"] || 0
      end

      def block(options = {}, &block_param)
        @blocks << new_block = Types::Block.new(options)
        new_block.instance_exec(&block_param) if block_given?
        self
      end

      def blocks=(values)
        raise ArgumentError unless values.is_a?(Array)
        @blocks = values.map do |value|
          value.is_a?(Types::Block) ? value : Types::Block.new(value)
        end
      end

      def name(*args)
        case args.length
        when 0 then @name
        when 1 then @name = args.first
        else raise ArgumentError
        end
      end

      def as_json
        {
          name: name,
          blocks: blocks.map(&:as_json)
        }
        .reject { |_,v| v.nil? }
      end

      def to_json(*args)
        JSON.generate(as_json)
      end
    end
  end
end
