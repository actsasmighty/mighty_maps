module MightyMaps
  class DSL
    autoload :Block, "mighty_maps/dsl/block"
    autoload :Defaults, "mighty_maps/dsl/defaults"
    autoload :Row, "mighty_maps/dsl/row"
    autoload :SeatMap, "mighty_maps/dsl/seat_map"

    def self.parse(&block_param)
      seat_map = Types::SeatMap.new
      DSL::SeatMap.new(seat_map).instance_exec(&block_param) if block_given?
      seat_map
    end
  end
end
