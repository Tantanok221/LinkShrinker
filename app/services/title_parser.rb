class TitleParser
  class TitleParseError < StandardError; end

  def initialize(html)
    @html = html
  end

  def call
    doc = Nokogiri::HTML(@html)
    doc.at_css("title").text.strip
  rescue Nokogiri::SyntaxError => e
    raise TitleParseError, "HTML parsing failed: #{e.message}"
  end
end
