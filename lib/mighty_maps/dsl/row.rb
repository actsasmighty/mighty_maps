module MightyMaps
  class DSL
    class Row
      def initialize(row, parent: nil, global: nil)
        @global = global
        @row = row
        @parent = parent
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

=begin
      def seat(number = nil, **options, &block_param)
        options[:number] = number || options[:number] || options["number"]
        @row.seats << new_seat = Types::Seat.new(options)
        DSL::Seat.new(new_seat, self).tap do |seat_dsl|
          seat_dsl.instance_exec(&block_param) if block_given?
        end
      end
=end

      def seats(values, **options)
        values.each.with_index do |seat_number, index|
          seat_rx = (options[:rx] || options["rx"]).to_f * index if options[:rx] || options["rx"]
          seat_ry = (options[:ry] || options["ry"]).to_f * index if options[:ry] || options["ry"]

          @row.seats << Types::Seat.new(options.merge(number: seat_number, rx: seat_rx, ry: seat_ry))
        end
      end

      def method_missing(method_name, *arguments, &block)
        if @global.respond_to?(method_name)
          @global.send(method_name, *arguments, &block)
        else
          super
        end
      end

      def respond_to_missing?(*args)
        super || @global.respond_to_missing(*args)
      end
    end
  end
end
