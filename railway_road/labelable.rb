module Labelable

  attr_reader :manufacturer

  def manufacturer=(manufacturer)
    validate_manufacturer!
    @manufacturer = manufacturer
  end

  def validate_manufacturer!(manufacturer)
    raise "Manufacturer can't be empty" unless manufacturer.present?
  end
end
