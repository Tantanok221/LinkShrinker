require "open-uri"

class ShortLink < ApplicationRecord
  validates :target_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :short_code, presence: true, uniqueness: true, length: { maximum: 15 }

  has_many :clicks, dependent: :destroy
  before_validation :normalize_target_url
  before_validation :generate_short_code, on: :create

  after_create :extract_title

  Logger = AppLogger.new("ShortLinkModels")

  def generate_short_code
    return if short_code.present?
    timestamp = (Time.now.to_i * 1000) & 0xFFFFFFFF # 32 bits
    sequence = SequenceCounter.next & 0xFFFF # 16 bits
    Logger.info("seed: #{timestamp}, #{sequence}")
    # Combine timestamp and sequence
    id = (timestamp << 16) | sequence
    Logger.info("id: #{id}")
    # Base62 encode and ensure 8 characters with leading zeros if needed
    id = id.base62_encode.rjust(8, "0")
    self.short_code = id
  end

  def extract_title
    self.title = PageExtractor.new(target_url).call
    save
  rescue StandardError => e
    self.title = "None"
    Logger.warn("Title extraction failed",
                 url: target_url,
                 error: e.message)
    save
  end

  def normalize_target_url
    self.target_url = UrlNormalizer.normalize(target_url)
  end

  def analytics_data
    cached = Rails.cache.fetch("analytics_#{self.short_code}")
    if cached.present?
      Rails.logger.info "[ShortLink] cache hit: #{cached.inspect}"
      return AnalyticsData.new(**cached)
    end
    Rails.logger.info "[ShortLink] cache miss!"

    data = {
      short_link: self,
      total_clicks: clicks.count,
      time_data: {
        daily: clicks.group_by_day(:created_at).count,
      weekly: clicks.group_by_week(:created_at).count,
        monthly: clicks.group_by_month(:created_at).count
      },
      geo_data: {
        country: clicks.group(:country).count,
        region: clicks.group(:region).count,
        city: clicks.group(:city).count
      },
      referrer_data: clicks.group(:referrer).count
    }
    Rails.cache.write("analytics_#{self.short_code}", data)
    AnalyticsData.new(
      **data
    )
  end
end
