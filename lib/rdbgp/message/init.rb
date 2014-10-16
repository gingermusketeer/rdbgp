require 'xmlsimple'
module Message
  # Handles serializing init messages
  class Init
    attr_reader :appid, :thread, :language, :protocol_version, :fileuri

    def initialize(opts)
      duped_opts = opts.dup
      @appid = duped_opts.delete(:appid)
      @idekey = duped_opts.delete(:idekey)
      @session = duped_opts.delete(:session)
      @thread = duped_opts.delete(:thread)
      @parent = duped_opts.delete(:parent)
      @language = duped_opts.delete(:language)
      @protocol_version = duped_opts.delete(:protocol_version)
      @fileuri = duped_opts.delete(:fileuri)
    end

    def idekey
      ENV['DBGP_IDEKEY'] || @idekey
    end

    def session
      ENV['DBGP_COOKIE'] || @session
    end

    def parent
      ENV['APPID'] || @parent
    end

    def to_xml
      XmlSimple.xml_out(to_h, xml_config)
    end

    def to_s
      "#{to_xml.length}\x00#{to_xml}\x00"
    end

    def to_h
      {
        init: {
          xmlns: xml_namespace, appid: appid, idekey: idekey, session: session,
          thread: thread, parent: parent, language: language,
          protocol_version: protocol_version, fileuri: fileuri
        }
      }
    end

    def xml_namespace
      'urn:debugger_protocol_v1'
    end

    def xml_config
      {
        keep_root: true,
        xmldeclaration: '<?xml version="1.0" encoding="UTF-8"?>'
      }
    end
  end
end
