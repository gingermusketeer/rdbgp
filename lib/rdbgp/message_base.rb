class MessageBase
  def to_xml
    XmlSimple.xml_out(to_h, xml_config)
  end

  def to_s
    "#{to_xml.length}\x00#{to_xml}\x00"
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
