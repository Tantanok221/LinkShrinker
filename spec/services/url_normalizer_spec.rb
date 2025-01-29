require 'services/url_normalizer'

RSpec.describe UrlNormalizer do
  describe ".normalize" do
    context "when the URL is blank" do
      it "returns nil" do
        expect(UrlNormalizer.normalize("")).to be_nil
        expect(UrlNormalizer.normalize("   ")).to be_nil
      end
    end

    context "when the URL has no scheme" do
      it "prepends the default scheme (https)" do
        expect(UrlNormalizer.normalize("example.com")).to eq("https://example.com")
        expect(UrlNormalizer.normalize("www.example.com")).to eq("https://www.example.com")
      end
    end

    context "when the URL already has a scheme" do
      it "returns the URL as is" do
        expect(UrlNormalizer.normalize("http://example.com")).to eq("http://example.com")
        expect(UrlNormalizer.normalize("https://example.com")).to eq("https://example.com")
        expect(UrlNormalizer.normalize("ftp://example.com")).to eq("ftp://example.com")
      end
    end

    context "when the URL is invalid but can be stripped" do
      it "returns the stripped URL" do
        expect(UrlNormalizer.normalize("  example.com  ")).to eq("https://example.com")
        expect(UrlNormalizer.normalize("  http://example.com  ")).to eq("http://example.com")
      end
    end

    context "when the URL is invalid and cannot be parsed" do
      it "should remove the invalid part and only take the first part" do
        invalid_url = "http://example.com/path with spaces"
        expect(UrlNormalizer.normalize(invalid_url)).to eq("http://example.com/path")
      end
    end
  end
end
