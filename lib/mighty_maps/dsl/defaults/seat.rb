module MightyMaps
  class DSL
    class Defaults
      class Seat
        autoload :Seat, "mighty_maps/dsl/defaults/seat"

        def initialize(defaults)
          @defaults = defaults
        end

        def margin(value)
          @defaults[:margin] = value
        end

        def rx(value)
          @defaults[:rx] = value
        end

        def ry(value)
          @defaults[:ry] = value
        end

        def size(value)
          @defaults[:size] = value
        end
      end
    end
  end
end
