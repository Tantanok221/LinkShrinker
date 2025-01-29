module LocationTracker
  def self.track(ip_address)
    Rails.logger.info "Ip address #{ip_address}"
    item = Geocoder.address(ip_address)
    Rails.logger.info "Item: #{item}"
    search_item = Geocoder.search(ip_address)
    Rails.logger.info "Search item: #{item}"

    item
  end
end
