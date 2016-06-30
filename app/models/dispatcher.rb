class Dispatcher
  class << self
    def run(description:, address:)
      pickup = create_address(address)
      Move.create!(description: description, address: pickup).tap do |move|
        dispatch(move)
      end
    end

    def create_address(raw)
      info = geocode(raw)

      Address.create!(
        number:  find_component(:street_number, info),
        street:  find_component(:route, info),
        city:    find_component(:locality, info, :long_name),
        state:   find_component(:administrative_area_level_1, info),
        country: find_component(:country, info, :long_name))
    end

    def geocode(raw)
      Geocoder.search(raw).first.tap do |info|
        raise "Could not find address: #{raw}" unless info
      end
    end

    def find_component(name, info, field = :short_name)
      return unless address_part = info.address_components.find do |component|
        component["types"].include?(name.to_s)
      end
      address_part[field.to_s]
    end

    def dispatch(move)
      params = {
        notes:  move.description,
        number: move.address.number,
        street: move.address.street,
        city:   move.address.city,
        state:  move.address.state
      }
      RestClient.post("https://onfleet.com/api/v2/tasks", params)
    end
  end
end
