describe "Integration tests" do
  describe "Map with blocks" do
    it do
      my_map = MightyMaps::Types::SeatMap.new do
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
      end

      #w = MyMap.to_ruby #(blocks: :verbose)

      binding.pry
    end
  end
end
