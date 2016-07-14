module MightyMaps
  module Types
    class Block
      attr_accessor :description
      attr_accessor :name
      attr_accessor :rows
      attr_accessor :seats

      def initialize(name = nil, **options, &block_param)
        self.description = options[:description] || options["description"]
        self.name = name || options[:name] || options["name"]
        self.rows = options[:rows] || options["rows"] || []
        self.seats = options[:seats] || options["seats"] || []

        instance_exec(&block_param) if block_given?
      end

      def description(*args)
        case args.length
        when 0 then @description
        when 1 then @description = args.first
        else raise ArgumentError
        end
      end

      def name(*args)
        case args.length
        when 0 then @name
        when 1 then @name = args.first
        else raise ArgumentError
        end
      end

      def row(row_number = nil, **options, &block_param)
        options =
        if row_number
          options.reject { |key, _| key == :number || key == "number" }.merge(number: row_number)
        else
          options
        end

        new_row = Types::Row.new(options)
        new_row.instance_exec(&block_param) if block_given?
        self.rows << new_row
        self
      end

      def rows=(values)
        binding.pry unless values.is_a?(Array)
        raise ArgumentError unless values.is_a?(Array)
        @rows = values.map do |value|
          value.is_a?(Types::Row) ? value : Types::Row.new(value)
        end
      end

      def seat(options = {}, &block_param)
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
