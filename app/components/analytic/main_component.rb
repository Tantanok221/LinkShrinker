class Analytics::AnalyticsComponent < ViewComponent::Base
  include Chartkick::Helper

  def initialize(short_link:, total_clicks:, time_data:, geo_data:, referrer_data:)
    @short_link = short_link
    @total_clicks = total_clicks
    @time_data = time_data
    @geo_data = geo_data
    @referrer_data = referrer_data
  end

  private

  attr_reader :short_link, :total_clicks, :time_data, :geo_data, :referrer_data
end