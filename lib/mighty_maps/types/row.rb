module MightyMaps
  module Types
    class Row
      attr_accessor :angle
      attr_accessor :number
      attr_accessor :seats
      attr_accessor :rx
      attr_accessor :ry

      DEFAULT_ANGLE = 90

      def initialize(options = {})
        self.angle = options[:angle] || options["angle"] || self.class::DEFAULT_ANGLE
        self.number = options[:name] || options["name"]
        self.seats = options[:seats] || options["seats"] || []
        self.rx = options[:rx] || options["rx"]
        self.ry = options[:ry] || options["ry"]
      end

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
    end
  end
end
