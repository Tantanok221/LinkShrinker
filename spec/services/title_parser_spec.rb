require 'rspec'
require 'nokogiri'
require 'services/title_parser' # Adjust the path to your TitleParser file

describe TitleParser do
  describe "#call" do
    context "when the HTML has a valid title" do
      it "returns the title" do
        html = '<html><head><title>Test Title</title></head><body></body></html>'
        parser = TitleParser.new(html)

        expect(parser.call).to eq("Test Title")
      end
    end

    context "when the HTML does not have a title tag" do
      it "raises a TitleParseError" do
        html = '<html><head></head><body></body></html>'
        parser = TitleParser.new(html)

        expect { parser.call }.to raise_error
      end
    end
  end
end
