class TitleParser
  class TitleParseError < StandardError; end

  def initialize(html)
    @html = html
  end

  def call
    doc = Nokogiri::HTML(@html)
    title = doc.at_css("title").text.strip
    title.empty? ? raise(TitleParseError, "Empty title") : title
  rescue Nokogiri::SyntaxError => e
    raise TitleParseError, "HTML parsing failed: #{e.message}"
  end
end