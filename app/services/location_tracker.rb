module LocationTracker
  def self.track(ip_address)
    item = Geocoder.address(ip_address)
    Rails.logger.info "Ip Address: #{item}"
    item
  end
end
