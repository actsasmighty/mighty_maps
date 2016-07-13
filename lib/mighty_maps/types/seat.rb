module MightyMaps
  module Types
    class Seat
      include Virtus.model

      attribute :x, Integer
      attribute :y, Integer
      attribute :row, String
      attribute :number, String

      def number(*args)
        case args.length
        when 0 then @number
        when 1 then @number = args.first
        else raise ArgumentError
        end
      end

      def row(*args)
        case args.length
        when 0 then @row
        when 1 then @row = args.first
        else raise ArgumentError
        end
      end

      def x(*args)
        case args.length
        when 0 then @x
        when 1 then @x = args.first
        else raise ArgumentError
        end
      end

      def y(*args)
        case args.length
        when 0 then @y
        when 1 then @y = args.first
        else raise ArgumentError
        end
      end
    end
  end
end

