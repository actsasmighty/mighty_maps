describe "Integration tests" do
  describe "Map with blocks" do
    it do
      map = MightyMaps::DSL.parse do
        name "Hall of fame"

        defaults :seat do
          margin 2
          size 10
        end

        block "Pit left", rx: 12.12, ry: 14.14 do
          points [
            { rx: 489.21, ry: 393.89 },
            { rx: 341.21, ry: 445.89 },
            { rx: 345.21, ry: 705.89 },
            { rx: 509.21, ry: 677.89 },
            { rx: 625.21, ry: 605.89 }
          ]

          row "A", rx: 100, ry: 50, angle: 90.0 do
            seats 1..12, rx: :auto
          end

          row "B", rx: 100, ry: 80 do
            seats 1..13, rx: :auto
          end
        end

        block do
          name "Balcony right"
          rx 341.21
          ry 393.89

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
