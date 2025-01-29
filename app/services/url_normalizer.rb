require 'uri'

class UrlNormalizer
  DEFAULT_SCHEME = 'https'.freeze

  def self.normalize(url)
    return nil if url.nil? || url.strip.empty?

    url = url.strip

    unless url.include?('://')
      url = "#{DEFAULT_SCHEME}://#{url}"
    end
    url.split(" ").first
  rescue StandardError
    url
  end
end
