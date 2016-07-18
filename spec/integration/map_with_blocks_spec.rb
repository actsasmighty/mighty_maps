describe "Integration tests" do
  describe "Map with blocks" do
    it do
      map = MightyMaps::Types::SeatMap.new do
        name "Hall of fame"

        # verbose writing
        block do
          name "B5"
          description "Eingangsblock"

          seat do
            x 12.1
            y 54.1
            row 3
            number 6
          end
        end

        # short writing
        block name: "B6", description: "Ausgangsblock" do
          seat x: 1.1, y: 2.1, row: "5", number: "6"
        end

        # mixed writing
        block do
          name "B7"
          description "Middle block"

          seat x: 1.1, y: 2.1, row: 5, number: 6
        end

        block "B8" do
          description "foo"

          row number: 1 do
            seat 1
          end

          row do
            number 2

            seat 2
          end

          row 3 do
            seat 3, x: 1.1, y: 2.1
          end
        end
      end

      binding.pry

      # B5
      expect(map.blocks[0].name).to eq("B5")
      expect(map.blocks[0].description).to eq("Eingangsblock")
      expect(map.blocks[0].seats[0].x).to eq(12.1)
      expect(map.blocks[0].seats[0].y).to eq(54.1)
      expect(map.blocks[0].seats[0].row).to eq("3") # integers should be casted to strings
      expect(map.blocks[0].seats[0].number).to eq("6")

      #B6
      expect(map.blocks[1].name).to eq("B6")
      expect(map.blocks[1].description).to eq("Ausgangsblock")
      expect(map.blocks[1].seats[0].x).to eq(1.1)
      expect(map.blocks[1].seats[0].y).to eq(2.1)
      expect(map.blocks[1].seats[0].row).to eq("5")
      expect(map.blocks[1].seats[0].number).to eq("6")
      #binding.pry
    end
  end
end
