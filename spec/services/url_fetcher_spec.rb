require 'rspec'
require 'open-uri'
require 'services/url_fetcher'

RSpec.describe UrlFetcher do
  let(:valid_url) { 'https://example.com' }
  let(:invalid_url) { 'https://invalid-url.com' }

  describe '#call' do
    context 'when the URL is valid' do
      it 'returns the content of the URL' do
        content = '<html><body>Example Content</body></html>'

        # Stub the URI.open method to return fake content
        allow(URI).to receive(:open).with(valid_url).and_return(double(read: content))

        fetcher = UrlFetcher.new(valid_url)
        expect(fetcher.call).to eq(content)
      end
    end

    context 'when the URL is invalid' do
      it 'raises a UrlFetchError' do
        allow(URI).to receive(:open).with(invalid_url).and_raise(StandardError, 'Invalid URL')

        fetcher = UrlFetcher.new(invalid_url)
        expect { fetcher.call }.to raise_error(UrlFetcher::UrlFetchError, /Failed to fetch URL/)
      end
    end
  end
end
