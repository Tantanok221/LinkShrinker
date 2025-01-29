require 'services/url_normalizer'

describe UrlNormalizer do
  let(:http_url) { "http://example.com" }
  let(:https_url) { "https://example.com" }
  describe ".normalize" do
    context "when the URL is blank" do
      it "returns nil" do
        expect(UrlNormalizer.normalize("")).to be_nil
        expect(UrlNormalizer.normalize("   ")).to be_nil
      end
    end

    context "when the URL has no scheme" do
      it "prepends the default scheme (https)" do
        expect(UrlNormalizer.normalize("example.com")).to eq(https_url)
        expect(UrlNormalizer.normalize("www.example.com")).to eq("https://www.example.com")
      end
    end

    context "when the URL already has a scheme" do
      it "returns the URL as is" do
        expect(UrlNormalizer.normalize(http_url)).to eq(http_url)
        expect(UrlNormalizer.normalize(https_url)).to eq(https_url)
        expect(UrlNormalizer.normalize("ftp://example.com")).to eq("ftp://example.com")
      end
    end

    context "when the URL is invalid but can be stripped" do
      it "returns the stripped URL" do
        expect(UrlNormalizer.normalize("  example.com  ")).to eq(https_url)
        expect(UrlNormalizer.normalize("  http://example.com  ")).to eq(http_url)
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
