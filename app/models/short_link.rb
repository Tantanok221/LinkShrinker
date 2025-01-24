require 'open-uri'

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

    loop do
      self.short_code = SecureRandom.alphanumeric(15)
      break unless ShortLink.exists?(short_code: short_code)
    end
  end

  def extract_title
    Logger.info("Extracting page title", url: target_url)

    doc = Nokogiri::HTML(URI.open(target_url))
    self.title = doc.at_css("title").text.strip
    Logger.info("Title extraction successful", title: title)
    save
  rescue StandardError => e
    Logger.error("Title extraction failed",
                 url: target_url,
                 error: e.message)
  end

  def normalize_target_url
    self.target_url = UrlNormalizer.normalize(target_url)
  end
end
