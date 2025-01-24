require 'open-uri'

class ShortLink < ApplicationRecord
  validates :target_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :short_code, presence: true, uniqueness: true, length: { maximum: 15 }

  has_many :clicks, dependent: :destroy

  before_validation :generate_short_code, on: :create

  after_create :extract_title

  def generate_short_code
    return if short_code.present?

    loop do
      self.short_code = SecureRandom.alphanumeric(15)
      break unless ShortLink.exists?(short_code: short_code)
    end
  end

  def extract_title
    Rails.logger.info "Target url from the incoming request: #{target_url}"
    doc = Nokogiri::HTML(URI.open(target_url))
    self.title = doc.at_css("title").text.strip
    Rails.logger.info "Title from the incoming url: #{title}"
    save
  rescue StandardError => e
    # Handle errors (e.g., invalid URL, connection issues)
    Rails.logger.error "Failed to extract title for URL: #{target_url}. Error: #{e.message}"
  end
end
