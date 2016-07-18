module MightyMaps
  class DSL
    class SeatMap
      def initialize(seat_map)
        @defaults = {}
        @seat_map = seat_map
      end

      def block(name = nil, **options, &block_param)
        options[:name] = name || options[:name] || options["name"]
        @seat_map.blocks << new_block = Types::Block.new(options)
        DSL::Block.new(new_block).tap do |block_dsl|
          block_dsl.instance_variable_set(:@defaults, @defaults)
          block_dsl.instance_exec(&block_param) if block_given?
        end
      end

      def defaults(key = nil, **options, &block_param)
        defaults_dsl = DSL::Defaults.new(@defaults)
        key_dsl = defaults_dsl.send(key, options) if key

        if block_given?
          if key_dsl
            key_dsl.instance_exec(&block_param)
          else
            defaults_dsl.instance_exec(&block_param)
          end
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
