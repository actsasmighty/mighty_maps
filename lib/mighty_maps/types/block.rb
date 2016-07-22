module MightyMaps
  module Types
    class Block
      attr_accessor :description
      attr_accessor :name
      attr_accessor :points
      attr_accessor :rows
      attr_accessor :seats
      attr_accessor :rx
      attr_accessor :ry
      attr_accessor :x
      attr_accessor :y

      include MightyMaps::CallUnlessNil
      include MightyMaps::FixedPrecisionAdd

      private :call_unless_nil
      private :fadd

      def initialize(options = {})
        call_unless_nil(:description=, options[:description] || options["description"])
        call_unless_nil(:name=, options[:name] || options["name"])
        call_unless_nil(:points=, options[:points] || options["points"] || [])
        call_unless_nil(:rows=, options[:rows] || options["rows"] || [])
        call_unless_nil(:seats=, options[:seats] || options["seats"] || [])
        call_unless_nil(:rx=, options[:rx] || options["rx"])
        call_unless_nil(:ry=, options[:ry] || options["ry"])
        call_unless_nil(:x=, options[:x] || options["y"])
        call_unless_nil(:y=, options[:y] || options["y"])
      end

      public # custom accessors
      
      def points=(values)
        raise ArgumentError unless values.is_a?(Array)
        @points = values.map do |value|
          value.is_a?(Types::Point) ? value : Types::Point.new(value)
        end
      end

      def seats=(values)
        raise ArgumentError unless values.is_a?(Array)
        @seats = values.map do |value|
          value.is_a?(Types::Seat) ? value : Types::Seat.new(value)
        end
      end

      public # methods

      def left_bottom
        bounding_box.left_bottom
      end
      
      def left_top
        bounding_box.left_top
      end

      public # normalization

      def normalize(reference = Types::Point.new(x: 0, y: 0))
        abs_x = fadd(reference.x, rx)
        abs_y = fadd(reference.y, ry)
        descendants_reference = bounding_box.normalize(Types::Point.new(x: abs_x, y: abs_y)).left_top

        self.class.new(
          description: description,
          name: name,
          points: points.map do |block_point|
            block_point.normalize(descendants_reference)
          end,
          rows: rows.map do |block_row|
            block_row.normalize(descendants_reference)
          end,
          x: abs_x,
          y: abs_y
        )
      end

      public # serialization
      
      def as_json
        {
          description: description,
          name: name,
          points: points.map(&:as_json),
          rows: rows.map(&:as_json),
          seats: seats.map(&:as_json)
        }
        .reject { |_, value| value.nil? || (value.respond_to?(:empty?) && value.empty?) }
      end

      def to_json(options = nil)
        JSON.generate(as_json, options)
      end

      private # helpers
    
      def bounding_box
        Types::Rectangle.new(
          left_top: {
            rx: points.min_by { |block_point| block_point.rx }.rx,
            ry: points.min_by { |block_point| block_point.ry }.ry
          },
          left_bottom: {
            rx: points.min_by { |block_point| block_point.rx }.rx,
            ry: points.max_by { |block_point| block_point.ry }.ry
          },
          right_top: {
            rx: points.max_by { |block_point| block_point.rx }.rx,
            ry: points.min_by { |block_point| block_point.ry }.ry
          },
          right_bottom: {
            rx: points.max_by { |block_point| block_point.rx }.rx,
            ry: points.max_by { |block_point| block_point.ry }.ry
          }
        )
      end
    end
  end
end
