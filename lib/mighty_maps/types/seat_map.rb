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

      public # custom accessors

      def blocks=(values)
        raise ArgumentError unless values.is_a?(Array)
        @blocks = values.map do |value|
          value.is_a?(Types::Block) ? value : Types::Block.new(value)
        end
      end

      public # normalization

      def normalize
        abs_x = x
        abs_y = y

        self.class.new(
          blocks: blocks.map do |seat_map_block|
            seat_map_block.normalize(Types::Point.new(x: abs_x, y: abs_y))
          end,
          name: name,
          x: abs_x,
          y: abs_y,
        )
      end

      public # serialization

      def as_json
        {
          name: name,
          blocks: blocks.map(&:as_json)
        }
        .reject { |_, value| value.nil? || (value.respond_to?(:empty?) && value.empty?) }
      end

      def to_json(*args)
        JSON.generate(as_json)
      end
    end
  end
end
