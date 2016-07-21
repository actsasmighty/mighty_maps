module MightyMaps
  class DSL
    class SeatMap
      def initialize(seat_map)
        @global = Object.new
        @seat_map = seat_map
      end

      def block(name = nil, **options, &block_param)
        options[:name] = name || options[:name] || options["name"]
        @seat_map.blocks << new_block = Types::Block.new(options)
        DSL::Block.new(new_block, global: @global, parent: self, seat_map: @seat_map).tap do |block_dsl|
          block_dsl.instance_exec(&block_param) if block_given?
        end
      end

      def define(key, value)
        @global.define_singleton_method key do
          value
        end
      end

      def name(value)
        @seat_map.name = value
      end

      def x(value)
        @seat_map.x = value
      end

      def y(value)
        @seat_map.y = value
      end
    end
  end
end
