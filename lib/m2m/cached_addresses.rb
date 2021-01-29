module M2m::CachedAddresses
  def cached_addresses
    @cached_addresses ||= self.addresses.order([:fcaddrkey, :fcaddrtype]).all
  end

  # For NS export
  def with_cached_address(index, &proc)
    if address = self.cached_addresses[index-1]
      yield(address)
    else
      ''
    end
  end

  def default_billing?(address)
    self.cached_addresses.each do |a|
      if a.bill_to?
        return (a == address)
      end
    end
    self.cached_addresses.each do |a|
      if a.sold_to?
        return (a == address)
      end
    end
    false
  end

  def default_shipping?(address)
    self.cached_addresses.each do |a|
      if a.ship_to?
        return (a == address)
      end
    end
  end
end