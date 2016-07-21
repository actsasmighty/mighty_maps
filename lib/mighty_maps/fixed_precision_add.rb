require "json"

module MightyMaps
  module FixedPrecisionAdd
    def fadd(a, b, digits: 2) # fixed point add to circumvent float addition rounding issues
      (Integer(a * 10**digits) + Integer(b * 10**digits)) / Float(10**digits)
    end
  end
end
