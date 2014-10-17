require 'rdbgp/command/step_into'
require 'ostruct'

describe Command::StepInto do
  let(:valid_parameters) { OpenStruct.new(flags: { i: '1' }) }
  let(:invalid_parameters) { OpenStruct.new(flags: {}) }
  let(:valid_command) { described_class.new(valid_parameters) }
  let(:invalid_command) { described_class.new(invalid_parameters) }

  it 'is valid with required parameters' do
    expect(valid_command.valid?).to be true
    expect(invalid_command.valid?).to be false
  end

  it 'has errors when it is invalid' do
    valid_command.valid?
    expect(valid_command.errors).to eql []

    invalid_command.valid?
    expect(invalid_command.errors).to eql [
      "Flag: '-i' is missing"
    ]
  end
end
