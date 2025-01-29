require "services/short_code_generator"
require "base62"
describe ShortCodeGenerator do
  let(:mock_logger) { double('AppLogger', info: nil) }
  let(:sequence_counter) { double('SequenceCounter') }

  before do
    allow(sequence_counter).to receive(:next).and_return(1)
  end

  describe "#generate" do
    context "have 8 characters" do
      it "generates a code with 8 characters" do
        code = ShortCodeGenerator.generate(logger: mock_logger, sequence_counter: sequence_counter)
        expect(code.length).to eq(8)
      end
    end
  end
end
