module MightyMaps
  module Types
    class Row
      attr_accessor :number
      attr_accessor :seats

      def initialize(number = nil, **options, &block_param)
        self.number = number || options[:number] || options["number"]
        self.seats = options[:seats] || options["seats"] || []

        instance_exec(&block_param) if block_given?
      end

      def number(*args)
        case args.length
        when 0 then @number
        when 1 then @number = args.first
        else raise ArgumentError
        end
      end

      def seat(seat_number = nil, **options, &block_param)
        options =
        if seat_number
          options.reject { |key, _| key == :number || key == "number" }.merge(number: seat_number)
        else
          options
        end

        new_seat = Types::Seat.new(options)
        new_seat.instance_exec(&block_param) if block_given?
        @seats << new_seat
      end

      def seats=(values)
        raise ArgumentError unless values.is_a?(Array)
        @seats = values.map do |value|
          value.is_a?(Types::Seat) ? value : Types::Seat.new(value)
        end
      end
    end
  end
end
