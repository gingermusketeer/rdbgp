require 'rdbgp/command_factory'

describe CommandFactory do
  describe '.build' do
    it 'creates a valid status command' do
      command = described_class.build('status -i transaction_id')
      expect(
        command.class
      ).to be Command::Status
      expect(command.valid?).to be true
    end
  end
end
