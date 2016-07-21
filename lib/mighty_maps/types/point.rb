module MightyMaps
  module Types
    class Point
      attr_accessor :rx
      attr_accessor :ry
      attr_accessor :x
      attr_accessor :y

      def initialize(options = {})
        self.rx = options && (options[:rx] || options["rx"])
        self.ry = options && (options[:ry] || options["ry"])
        self.x = options && (options[:x] || options["x"])
        self.y = options && (options[:y] || options["y"])
      end

      def as_json
        {
          rx: rx,
          ry: ry,
          x: x,
          y: y,
        }
        .reject { |_, value| value.nil? }
      end

      def to_json(options = nil)
        JSON.generate(as_json, options)
      end
    end
  end
end

