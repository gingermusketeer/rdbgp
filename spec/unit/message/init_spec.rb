require 'rdbgp/message/init'

describe Message::Init do
  subject do
    Message::Init.new(
      appid: 'APPID',
      idekey: 'IDE_KEY',
      session: 'DBGP_COOKIE',
      thread: 'THREAD_ID',
      parent: 'PARENT_APPID',
      language: 'LANGUAGE_NAME',
      protocol_version: '1.0',
      fileuri: 'file://path/to/file'
    )
  end

  describe '.to_xml' do
    it 'uses passed in properties in xml output' do
      expect(subject.to_xml).to eql(
        %q(<init appid="APPID"
      idekey="IDE_KEY"
      session="DBGP_COOKIE"
      thread="THREAD_ID"
      parent="PARENT_APPID"
      language="LANGUAGE_NAME"
      protocol_version="1.0"
      fileuri="file://path/to/file">)
      )
    end
  end
end
