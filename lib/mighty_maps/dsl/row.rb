module MightyMaps
  class DSL
    class Row
      def initialize(row)
        @row = row
      end

      def defaults
        @defaults
      end

      def number(value)
        @row.number = value
      end

      def rx(value)
        @row.rx = value
      end

      def ry(value)
        @row.ry = value
      end

      def seat(number = nil, **options, &block_param)
        options[:number] = number || options[:number] || options["number"]
        options[:size] = options[:size] || options["size"] || @defaults[:seat][:size]

        @row.seats << new_row = Types::Seat.new(options)
        DSL::Row.new(new_row).tap do |seat_dsl|
          seat_dsl.instance_variable_set(:@defaults, @defaults)
          seat_dsl.instance_exec(&block_param) if block_given?
        end
      end

      def seats(values, **options)
        values.each.with_index do |seat_number, index|
          @row.seats << Types::Seat.new(options.merge(number: seat_number))
        end
      end
    end
  end
end
