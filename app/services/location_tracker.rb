module LocationTracker
  def self.track(ip_address)
    Geocoder.search(ip_address).first
  end
end