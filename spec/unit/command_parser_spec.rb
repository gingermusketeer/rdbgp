require 'rdbgp/command_parser'
require 'base64'

describe CommandParser do
  describe '#parse' do
    it 'parses the command name' do
      expect(described_class.parse("status\x00").command_name).to be :status
    end

    it 'parses any flags with value' do
      result = { i: 'id' }
      expect(described_class.parse("status -i id\x00").flags).to eql result
    end

    it 'parses commands with data' do
      data = Base64.encode64('howdy')
      expect(described_class.parse(
        "status -- #{data}\x00"
      ).data).to eql 'howdy'
    end
  end
end
