module MightyMaps
  class DSL
    class Block
      def initialize(block)
        @block = block
      end

      def name(value)
        @block.name = value
      end

      def point(value)
        @block.points << value
      end

      def points(values)
        @block.points.concat(values)
      end

      def row(name = nil, **options, &block_param)
        options[:name] = name || options[:name] || options["name"]
        @block.rows << new_row = Types::Row.new(options)
        DSL::Row.new(new_row).tap do |row_dsl|
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
