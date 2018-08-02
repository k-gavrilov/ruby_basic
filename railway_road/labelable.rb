module Labelable

  attr_reader :manufacturer

  MANUFACTURER = /\S+/

  def manufacturer=(manufacturer)
    validate_manufacturer!
    @manufacturer = manufacturer
  end

  def validate_manufacturer!(manufacturer)
    raise 'Manufacturer is not a string' unless manufacturer.instance_of? String
    raise "Manufacturer can't be empty" unless manufacturer =~ MANUFACTURER
  end
end
