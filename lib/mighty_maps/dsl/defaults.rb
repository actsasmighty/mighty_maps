module MightyMaps
  class DSL
    class Defaults
      autoload :Seat, "mighty_maps/dsl/defaults/seat"

      def initialize(defaults)
        @defaults = defaults
        @defaults[:seat] ||= {}
      end

      def seat(**options, &block_param)
        @defaults[:seat].merge!(options) unless options.empty?
        DSL::Defaults::Seat.new(@defaults[:seat]).tap do |seat_dsl|
          seat_dsl.instance_exec(&block_param) if block_given?
        end
      end
    end
  end
end
