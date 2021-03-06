require 'rdbgp/command_factory'

describe CommandFactory do
  describe '.build' do
    it 'creates a valid status command' do
      command = described_class.build('status -i transaction_id')
      expect(command.class).to be Command::Status
      expect(command.valid?).to be true
    end

    it 'creates a valid feature_set command' do
      command = described_class.build(
        'feature_set -i 1 -n "max_children" -v "2048"'
      )
      expect(command.class).to be Command::FeatureSet
      expect(command.valid?).to be true
    end

    it 'creates a valid step_into command' do
      command = described_class.build(
        'step_into -i 3'
      )
      expect(command.class).to be Command::StepInto
      expect(command.valid?).to be true
    end
  end
end
