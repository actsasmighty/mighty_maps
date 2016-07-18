module MightyMaps
  module Types
    class Seat
      attr_accessor :number
      attr_accessor :rx
      attr_accessor :ry
      attr_accessor :size
      attr_accessor :x
      attr_accessor :y

      def initialize(options = {}, &block_param)
        self.number = options[:number] || options["number"]
        self.rx = options[:rx] || options["rx"]
        self.ry = options[:ry] || options["ry"]
        self.size = options[:size] || options["size"]
        self.x = options[:x] || options["x"]
        self.y = options[:y] || options["y"]
      end

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

