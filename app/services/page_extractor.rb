class PageExtractor
  attr_accessor :title

  def initialize(target_url, logger: AppLogger.new('page_extractor'), fetcher: UrlFetcher, parser: TitleParser)
    @target_url = target_url
    @logger = logger
    @fetcher = fetcher
    @parser = parser
  end

  def call
    @logger.info("Extracting element: #{@target_url}")

    html = @fetcher.new(@target_url).call
    element = @parser.new(html).call.strip
    @logger.info("Element found: #{element}")

    element

  rescue UrlFetcher::Error => e
    @logger.error("Fetch failed: #{e.message}")
    nil
  rescue TitleParser::Error => e
    @logger.error("Parse failed: #{e.message}")
    nil
  end
end