module MightyMaps
  module Types
    class SeatMap
      include Virtus.model
      
      attribute :name, String
      attribute :blocks, Array[Types::Block]

      def initialize(options = {}, &block_param)
        super
        instance_exec(&block_param) if block_given?
      end

      def block(options = {}, &block_param)
        @blocks << new_block = Types::Block.new(options)
        new_block.instance_exec(&block_param) if block_given?
        self
      end

      def name(*args)
        case args.length
        when 0 then @name
        when 1 then @name = args.first
        else raise ArgumentError
        end
      end
    end
  end
end
