module MightyMaps
  module Types
    class Row
      attr_accessor :number
      attr_accessor :seats
      attr_accessor :rx
      attr_accessor :ry
      attr_accessor :x
      attr_accessor :y

      include CallUnlessNil
      include FixedPrecisionAdd

      private :call_unless_nil
      private :fadd

      def initialize(options = {})
        call_unless_nil(:number=, options[:number] || options["number"])
        call_unless_nil(:seats=, options[:seats] || options["seats"] || [])
        call_unless_nil(:rx=, options[:rx] || options["rx"])
        call_unless_nil(:ry=, options[:ry] || options["ry"])
        call_unless_nil(:x=, options[:x] || options["y"])
        call_unless_nil(:y=, options[:y] || options["y"])
      end

      def normalize(reference = Types::Point.new(x: 0, y: 0))
        abs_x = x || fadd(reference.x, rx)
        abs_y = y || fadd(reference.y, ry)
        descendants_reference = Types::Point.new(x: abs_x, y: abs_y)

        self.class.new(
          number: number,
          seats: seats.map do |row_seat|
            row_seat.normalize(descendants_reference)
          end,
          x: abs_x,
          y: abs_y
        )
      end

      def as_json
        {
          number: number,
          seats: seats.map(&:as_json),
          rx: rx,
          ry: ry,
          x: x,
          y: y
        }
        .reject { |_, value| value.nil? }
      end

      def to_json(options = nil)
        JSON.generate(as_json, options)
      end
    end
  end
end
