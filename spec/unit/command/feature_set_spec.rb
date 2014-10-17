require 'rdbgp/command/feature_set'
require 'ostruct'

describe Command::FeatureSet do
  let(:valid_parameters) do
    OpenStruct.new(flags: { i: 1, n: 'max_children', v: 2048 })
  end
  let(:invalid_parameters) do
    OpenStruct.new(flags: {})
  end
  let(:valid_command) { described_class.new(valid_parameters) }
  let(:invalid_command) { described_class.new(invalid_parameters) }

  describe '#valid?' do
    it 'is valid when all flags are passed in' do
      expect(
        valid_command.valid?
      ).to be true
    end

    it 'is invalid when no flags are passed in' do
      expect(
        invalid_command.valid?
      ).to be false
    end
  end

  describe '#errors' do
    it 'has no errors when it is valid' do
      valid_command.valid?
      expect(valid_command.errors).to be_empty
    end

    it 'has errors when it is invalid' do
      invalid_command.valid?
      expect(
        invalid_command.errors
      ).to eql [
        "Flag: '-i' is missing",
        "Flag: '-n' is missing",
        "Flag: '-v' is missing"
      ]
    end
  end
end
