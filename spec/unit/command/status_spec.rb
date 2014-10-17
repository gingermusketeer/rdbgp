require 'rdbgp/command/status'
require 'ostruct'

describe Command::Status do
  let(:valid_opts) { OpenStruct.new(flags: { i: 'transaction_id' }) }
  let(:invalid_opts) { OpenStruct.new(flags: {}) }
  let(:valid_command) { described_class.new(valid_opts) }
  let(:invalid_command) { described_class.new(invalid_opts) }

  describe '#valid?' do
    it 'is valid when it has a transaction id' do
      expect(
        valid_command.valid?
      ).to be true

      expect(
        invalid_command.valid?
      ).to be false
    end
  end

  describe '#errors' do
    it 'is empty when #valid? has not been called' do
      expect(
        invalid_command.errors
      ).to eql []
    end

    it 'is populated with the errors when it is not valid' do
      invalid_command.valid?
      expect(
        invalid_command.errors
      ).to eql ["Flag: '-i' is missing"]
    end
  end
end
