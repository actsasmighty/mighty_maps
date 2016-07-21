module MightyMaps
  class DSL
    class Block
      def initialize(block, global: nil, parent: nil, seat_map: nil)
        @block = block
        @global = global
        @parent = parent
        @seat_map = seat_map
      end

      def blocks
        @seat_map.blocks.each_with_object({}) do |seat_map_block, result|
          result[seat_map_block.name] = seat_map_block
        end
      end

      def name(value)
        @block.name = value
      end

      def point(value)
        binding.pry
        @block.points = [@block.points, value].flatten(1) # force new array creation
      end

      def points(values)
        @block.points = values
      end

      def row(name = nil, **options, &block_param)
        options[:name] = name || options[:name] || options["name"]
        @block.rows << new_row = Types::Row.new(options)
        DSL::Row.new(new_row, parent: self, global: @global).tap do |row_dsl|
          row_dsl.instance_variable_set(:@defaults, @defaults)
          row_dsl.instance_exec(&block_param) if block_given?
        end
      end

      def rx(value)
        @block.rx = value
      end

      def ry(value)
        @block.ry = value
      end
    end
  end
end
