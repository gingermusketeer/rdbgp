require 'rdbgp/message/init'

describe Message::Init do
  let(:idekey) {}
  let(:session) {}
  let(:parent) {}
  subject do
    Message::Init.new(
      appid: 'APPID',
      idekey: idekey,
      session: session,
      thread: 'THREAD_ID',
      parent: parent,
      language: 'LANGUAGE_NAME',
      protocol_version: '1.0',
      fileuri: 'file://path/to/file'
    )
  end

  describe '.to_xml' do
    context 'properties are passed in' do
      let(:idekey) { 'IDE_KEY' }
      let(:session) { 'DBGP_COOKIE' }
      let(:parent) { 'PARENT_APPID' }

      it 'uses passed in properties' do
        expect(subject.to_xml).to eql(
          '<?xml version="1.0" encoding="UTF-8"?>' + "\n"\
          '<init appid="APPID"'\
                ' idekey="IDE_KEY"'\
                ' session="DBGP_COOKIE"'\
                ' thread="THREAD_ID"'\
                ' parent="PARENT_APPID"'\
                ' language="LANGUAGE_NAME"'\
                ' protocol_version="1.0"'\
                ' fileuri="file://path/to/file" />' + "\n"
        )
      end
    end

    context 'properties are set on env' do
      it 'uses env properties' do
        allow(ENV).to receive(:[]).with('DBGP_IDEKEY').and_return(
          'ENV_DBGP_IDEKEY'
        )
        allow(ENV).to receive(:[]).with('DBGP_COOKIE').and_return(
          'ENV_DBGP_COOKIE'
        )
        allow(ENV).to receive(:[]).with('APPID').and_return 'ENV_PARENT_APPID'

        expect(subject.to_xml).to eql(
        '<?xml version="1.0" encoding="UTF-8"?>' + "\n"\
        '<init appid="APPID"'\
              ' idekey="ENV_DBGP_IDEKEY"'\
              ' session="ENV_DBGP_COOKIE"'\
              ' thread="THREAD_ID"'\
              ' parent="ENV_PARENT_APPID"'\
              ' language="LANGUAGE_NAME"'\
              ' protocol_version="1.0"'\
              ' fileuri="file://path/to/file" />' + "\n"
        )
      end
    end
  end
end
