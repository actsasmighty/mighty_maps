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

      def initialize(options = {})
        self.description = options[:description] || options["description"]
        self.name = name || options[:name] || options["name"]
        self.points = (options[:points] || options["points"] || [])
        self.rows = options[:rows] || options["rows"] || []
        self.seats = options[:seats] || options["seats"] || []
        self.rx = options[:rx] || options["rx"]
        self.ry = options[:ry] || options["ry"]
      end

      #
      # custom accessors
      #
      def points=(values)
        raise ArgumentError unless values.is_a?(Array)
        @points = values.map do |value|
          value.is_a?(Types::Point) ? value : Types::Point.new(value)
        end
      end

      def left_bottom
        bounding_box.left_bottom
      end
      
      def left_top
        bounding_box.left_top
      end

      def seats=(values)
        raise ArgumentError unless values.is_a?(Array)
        @seats = values.map do |value|
          value.is_a?(Types::Seat) ? value : Types::Seat.new(value)
        end
      end

      #
      # serialization
      #
      def as_json
        {
          name: name,
          description: description,
          seats: seats.map(&:as_json)
        }
        .reject { |_, value| value.nil? }
      end

      def to_json(options = nil)
        JSON.generate(as_json, options)
      end

      #
      # private helpers
      #
      private
    
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
