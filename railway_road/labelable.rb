module Labelable

  attr_reader :manufacturer

  MANUFACTURER = /\S+/

  def manufacturer=(manufacturer)
    validate_manufacturer!
    @manufacturer = manufacturer
  end

  def validate_manufacturer!(manufacturer)
    raise "Manufacturer can't be nil" if manufacturer.nil?
    raise "Manufacturer can't be empty" unless manufacturer =~ MANUFACTURER
  end
end
