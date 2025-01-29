class ClickTracker
  def self.track_click(request, short_link, model: Click, logger: AppLogger.new("ClickTracker"))
    new(request, model: model, logger: logger).save(short_link)
  end

  def initialize(request, model: Click, logger:)
    @request = request
    @logger = logger
    @model = model
  end

  def save(short_link)
    @model.create!({ short_link: short_link,
                     **self.build_click_attributes
                   })
  end

  private

  def build_click_attributes(location_tracker: LocationTracker)
    @logger.info "X-Forwarded-For: #{@request.headers['X-Forwarded-For']}"
    @logger.info "X-Real-IP: #{@request.headers['X-Real-IP']}"
    @logger.info "Remote IP: #{@request.remote_ip}"
    location = location_tracker.track(@request.headers["X-Real-IP"])
    @logger.info(location)
    {
      ip_address: @request.remote_ip,
      user_agent: @request.user_agent,
      referrer: @request.referrer,
      country: location.country,
      region: location.region,
      city: location.city,
      created_at: Time.now,
      updated_at: Time.now
    }
  end
end
