class UrlFetcher
  class UrlFetchError < StandardError; end

  def initialize(url)
    @url = url
  end

  def call
    URI.open(@url).read
  rescue OpenURI::HTTPError, SocketError, Timeout::Error, Errno::ECONNREFUSED => e
    raise UrlFetchError, "Failed to fetch URL: #{e.message}"
  end
end
