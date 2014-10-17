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

    it 'strips quotes if present' do
      parsed_parameters = described_class.parse(
        'feature_set -i 1 -n "max_children" -v "2048"'
      )
      expect(parsed_parameters.flags).to eql(
        i: '1',
        n: 'max_children',
        v: '2048'
      )
    end

    it 'parses commands with data' do
      data = Base64.encode64('howdy')
      expect(described_class.parse(
        "status -- #{data}\x00"
      ).data).to eql 'howdy'
    end
  end
end
