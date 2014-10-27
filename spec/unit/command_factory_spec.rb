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

    it 'creates a valid stack_get command' do
      command = described_class.build(
        'stack_get -i 4'
      )
      expect(command.class).to be Command::StackGet
      expect(command.valid?).to be true
    end

    it 'creates a valid context_names command' do
      command = described_class.build(
        'context_names -i 5 -d 0'
      )
      expect(command.class).to be Command::ContextNames
      expect(command.valid?).to be true
    end

    it 'creates a valid context_get command' do
      command = described_class.build(
        'context_get -i 6 -d "0" -c "0"'
      )
      expect(command.class).to be Command::ContextGet
      expect(command.valid?).to be true
    end

    it 'creates a valid source command' do
      command = described_class.build(
        'source -i 6 -f "file:///Volumes/Data/Users/gingermusketeer/projects/rdbgp/test.rb"'
      )
      expect(command.class).to be Command::Source
      expect(command.valid?).to be true
    end

    it 'creates a valid step_over command' do
      command = described_class.build(
        'step_over -i 8'
      )
      expect(command.class).to be Command::StepOver
      expect(command).to be_valid
    end
  end
end
