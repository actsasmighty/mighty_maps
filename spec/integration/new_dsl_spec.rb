describe "Integration tests" do
  describe "Map with blocks" do
    it do
      map = MightyMaps::DSL.parse do
        name "Hall of fame"

        define :seat_margin, 2
        define :seat_size, 10

        block "Pit left", rx: 12.12, ry: 14.14 do
          points [
            { rx: 489.21, ry: 393.89 },
            { rx: 341.21, ry: 445.89 },
            { rx: 345.21, ry: 705.89 },
            { rx: 509.21, ry: 677.89 },
            { rx: 625.21, ry: 605.89 }
          ]

          row "A", rx: 20, ry: 200 do
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

      binding.pry
      map
    end
  end
end
