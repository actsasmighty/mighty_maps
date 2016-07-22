module MightyMaps
  module Types
    class Seat
      attr_accessor :number
      attr_accessor :rx
      attr_accessor :ry
      attr_accessor :size
      attr_accessor :x
      attr_accessor :y

      include MightyMaps::CallUnlessNil
      include MightyMaps::FixedPrecisionAdd

      private :call_unless_nil
      private :fadd

      def initialize(options = {})
        call_unless_nil(:number=, options[:number] || options["number"])
        call_unless_nil(:rx=, options[:rx] || options["rx"])
        call_unless_nil(:ry=, options[:ry] || options["ry"])
        call_unless_nil(:size=, options[:size] || options["size"])
        call_unless_nil(:x=, options[:x] || options["y"])
        call_unless_nil(:y=, options[:y] || options["y"])
      end

      public # normalization

      def normalize(reference = Types::Point.new(x: 0, y: 0))
        abs_x = x || fadd(reference.x, rx)
        abs_y = y || fadd(reference.y, ry)

        self.class.new(
          number: number,
          size: size,
          x: abs_x,
          y: abs_y
        )
      end

      public # serialization

      def as_json
        {
          x: x,
          y: y,
          number: number
        }
        .reject { |_, value| value.nil? }
      end

      def to_json(options = nil)
        JSON.generate(as_json, options)
      end
    end
  end
end

