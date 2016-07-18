module MightyMaps
  module Types
    class Seat
      attr_accessor :x # Integer
      attr_accessor :y # Integer
      attr_accessor :row # String
      attr_accessor :number # String

      def initialize(options = {}, &block_param)
        self.number = options[:number] || options["number"]
        self.row = options[:row] || options["row"]
        self.x = options[:x] || options["x"]
        self.y = options[:y] || options["y"]

        instance_exec(&block_param) if block_given?
      end

      def number(*args)
        case args.length
        when 0 then @number
        when 1 then self.number = args.first
        else raise ArgumentError
        end
      end

      def number=(value)
        @number = value.nil? ? nil : value.to_s
      end

      def row(*args)
        case args.length
        when 0 then @row
        when 1 then self.row = args.first
        else raise ArgumentError
        end
      end

      def row=(value)
        @row = value.nil? ? nil : value.to_s
      end

      def x(*args)
        case args.length
        when 0 then @x
        when 1 then self.x = args.first
        else raise ArgumentError
        end
      end

      def y(*args)
        case args.length
        when 0 then @y
        when 1 then self.y = args.first
        else raise ArgumentError
        end
      end

      #
      # serialization
      #
      def as_json
        {
          x: x,
          y: y,
          row: row,
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

