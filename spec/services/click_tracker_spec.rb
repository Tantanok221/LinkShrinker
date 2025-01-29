require "services/click_tracker"
require "services/location_tracker"

RSpec.describe ClickTracker do
  let(:request) do
    double(
      'Request',
      remote_ip: '123.45.67.89',
      user_agent: 'TestAgent',
      referrer: 'http://example.com'
    )
  end
  let(:short_link) { double('ShortLink') }
  let(:location) { double('Location', country: 'TestCountry', region: 'TestRegion', city: 'TestCity') }
  let(:model) { double('Model') }

  describe '.track_click' do
    it 'creates a click with the correct attributes using the specified model' do
      allow(LocationTracker).to receive(:track).with(request).and_return(location)
      current_time = Time.now
      allow(Time).to receive(:now).and_return(current_time)

      expected_attributes = {
        short_link: short_link,
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
        referrer: request.referrer,
        country: location.country,
        region: location.region,
        city: location.city,
        created_at: current_time,
        updated_at: current_time
      }

      expect(model).to receive(:create!).with(expected_attributes)
      described_class.track_click(request, short_link, model: model)
    end
  end

  describe '#save' do
    it 'uses the current time for timestamps' do
      click_tracker = described_class.new(request, model: model)
      allow(LocationTracker).to receive(:track).with(request).and_return(location)
      current_time = Time.now
      allow(Time).to receive(:now).and_return(current_time)

      expect(model).to receive(:create!).with(
        hash_including(created_at: current_time, updated_at: current_time)
      )

      click_tracker.save(short_link)
    end
  end

  describe 'handling location data' do
    context 'when location is present' do
      it 'includes location attributes' do
        click_tracker = described_class.new(request, model: model)
        allow(LocationTracker).to receive(:track).with(request).and_return(location)

        expect(model).to receive(:create!).with(
          hash_including(
            country: 'TestCountry',
            region: 'TestRegion',
            city: 'TestCity'
          )
        )

        click_tracker.save(short_link)
      end
    end

    context 'when location is nil' do
      it 'sets location attributes to nil' do
        click_tracker = described_class.new(request, model: model)
        allow(LocationTracker).to receive(:track).with(request).and_return(nil)

        expect(model).to receive(:create!).with(
          hash_including(
            country: nil,
            region: nil,
            city: nil
          )
        )

        click_tracker.save(short_link)
      end
    end
  end
end