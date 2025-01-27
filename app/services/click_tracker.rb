class ClickTracker
  def self.track_click(request, short_link, model: Click)
    new(request, model: model).save(short_link)
  end

  def initialize(request, model: Click)
    @request = request
    @model = model
  end

  def save(short_link)
    @model.create!({ short_link: short_link,
                     **self.build_click_attributes
                   })
  end

  private

  def build_click_attributes(location_tracker: LocationTracker)
    location = location_tracker.track(@request)
    {
      ip_address: @request.remote_ip,
      user_agent: @request.user_agent,
      referrer: @request.referrer,
      country: location&.country,
      region: location&.region,
      city: location&.city,
      created_at: Time.now,
      updated_at: Time.now,
    }
  end
end