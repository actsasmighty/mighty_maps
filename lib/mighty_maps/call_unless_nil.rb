require "json"

module MightyMaps
  module CallUnlessNil
    # This is used for example to only call setters if there is a value, and therefor keeping the debug views clean
    def call_unless_nil(method_name, *args)
      if !args.empty? && args.none?(&:nil?)
        send(method_name, *args)
      end
    end
  end
end
