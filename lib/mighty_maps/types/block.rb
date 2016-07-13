module MightyMaps
  module Types
    class Block
      def initialize(options = {})
        @description = options[:description]
        @name = options[:name]
        @seats = []
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

      def seat(options = {}, &block_param)
        new_seat = Types::Seat.new(options)
        new_seat.instance_exec(&block_param) if block_given?
        @seats << new_seat
      end

      def seats
        @seats
      end
    end
  end
end

