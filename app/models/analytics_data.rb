class AnalyticsData
  attr_reader :short_link, :total_clicks, :time_data, :geo_data, :referrer_data

  def initialize(short_link:, total_clicks:, time_data:, geo_data:, referrer_data:)
    @short_link = short_link
    @total_clicks = total_clicks
    @time_data = format_time_data(time_data)
    @geo_data = format_geo_data(geo_data)
    @referrer_data = normalize_data(referrer_data)
  end

  private

  def format_geo_data(data)
    {
      country: normalize_data(data[:country]),
      region: normalize_data(data[:region]),
      city: normalize_data(data[:city]),
    }
  end

  def normalize_data(raw_data)
    raw_data.transform_keys { |data| data.nil? ? "None" : data }
  end

  def format_time_data(raw_time_data)
    {
      daily: format_to_date(raw_time_data[:daily]),
      weekly: format_to_week(raw_time_data[:weekly]),
      monthly: format_to_month(raw_time_data[:monthly])
    }
  end

  def format_to_date(data_hash)
    data_hash.transform_keys { |key| key.strftime("%Y-%m-%d") }
  end
  def format_to_month(data_hash)
    data_hash.transform_keys { |key| key.strftime("%b") }
  end
  def format_to_week(data_hash)
    data_hash.transform_keys { |key| "Week #{key.strftime("%U").to_i + 1}" }
  end
end
