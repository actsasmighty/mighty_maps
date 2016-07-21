module MightyMaps
  module Types
    class Rectangle
      attr_accessor :left_top
      attr_accessor :left_bottom
      attr_accessor :right_top
      attr_accessor :right_bottom

      def initialize(options = {})
        self.left_top = options[:left_top] || options["left_top"]
        self.left_bottom = options[:left_bottom] || options["left_bottom"]
        self.right_top = options[:right_top] || options["right_top"]
        self.right_bottom = options[:right_bottom] || options["right_bottom"]
      end

      def left_top=(value)
        @left_top = value.is_a?(Point) ? value : Types::Point.new(value)
      end

      def left_bottom=(value)
        @left_bottom = value.is_a?(Point) ? value : Types::Point.new(value)
      end

      def normalize(reference = Types::Point.new(x: 0, y: 0))
        self.class.new(
          left_top: left_top.normalize(reference),
          left_bottom: left_bottom.normalize(reference),
          right_top: right_top.normalize(reference),
          right_bottom: right_bottom.normalize(reference)
        )
      end

      def right_top=(value)
        @right_top = value.is_a?(Point) ? value : Types::Point.new(value)
      end

      def right_bottom=(value)
        @right_bottom = value.is_a?(Point) ? value : Types::Point.new(value)
      end

      def as_json
        {
          left_top: left_top.as_json,
          left_bottom: left_bottom.as_json,
          right_top: right_top.as_json,
          right_bottom: right_bottom.as_json,
        }
        .reject { |_, value| value.nil? }
      end

      def to_json(options = nil)
        JSON.generate(as_json, options)
      end
    end
  end
end

