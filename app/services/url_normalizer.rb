# Encapsulates URL normalization rules for the app
class UrlNormalizer
  DEFAULT_SCHEME = "https"

  def self.normalize(url)
    return if url.blank?

    stripped_url = url.strip
    uri = URI.parse(stripped_url)

    uri.scheme ? stripped_url : build_secure_url(stripped_url)
  rescue URI::InvalidURIError
    stripped_url
  end

  private

  def self.build_secure_url(url)
    "#{DEFAULT_SCHEME}://#{url}"
  end
end