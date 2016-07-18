module MightyMaps
  module Types
    class Block
      attr_accessor :description
      attr_accessor :name
      attr_accessor :seats

      def initialize(name = nil, **options, &block_param)
        self.description = options[:description] || options["description"]
        self.name = name || options[:name] || options["name"]
        self.seats = options[:seats] || options["seats"] || []

        instance_exec(&block_param) if block_given?
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

      def row(arg = nil, number: nil, &block_param)
        RowContext.new(self, row: arg || number).instance_exec(&block_param) if block_given?
        self
      end

      def seat(number = nil, **options, &block_param)
        options =
        if number
          options.reject { |key, _| key == :number || key == "number" }.merge(number: number)
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

      #
      # Context
      #
      class RowContext
        def initialize(block, row: nil)
          @block = block
          @row = row.nil? ? nil : row.to_s # omit "drying" writer to not pollute DSL namespace further through context
        end

        def number(*args)
          case args.length
          when 0 then @row
          when 1 then @row = args.first.nil? ? nil : args.first.to_s
          else raise ArgumentError
          end
        end

        #
        # Block methods
        #
        def description(*args)
          @block.description(*args)
        end

        def name(*args)
          @block.name(*args)
        end

        def seat(number = nil, **options, &block_param)
          options =
          if @row
            options.reject { |key, _| key == :row || key == "row" }.merge(row: @row)
          else
            options
          end

          @block.seat(number, options)
        end
      end
    end
  end
end
