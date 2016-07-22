describe "Integration tests" do
  describe "Map with blocks" do
    it do
      map = MightyMaps::DSL.parse do
        name "Hall of fame"

        define :seat_margin, 2
        define :seat_size, 10

        block "Pit left", rx: 12.1, ry: 14.2 do
          points [
            { rx:  50, ry:  50 },
            { rx: 350, ry:  50 },
            { rx: 350, ry: 400 },
            { rx:  10, ry: 400 },
            { rx:  10, ry: 100 }
          ]

          row "A", rx: 55, ry: 70 do
            seats 1..12, rx: seat_size + seat_margin, ry: -seat_size
          end
        end

        block do
          name "Balcony left"
          rx blocks["Pit left"].left_top.rx
          ry blocks["Pit left"].left_bottom.ry + 100

          point rx: 489.21, ry: 393.89
          point rx: 341.21, ry: 445.89
          point rx: 345.21, ry: 705.89
          point rx: 509.21, ry: 677.89
          point rx: 625.21, ry: 605.89
        end
      end

      normalized_map = map.normalize
      binding.pry
      normalized_map
    end
  end
end
