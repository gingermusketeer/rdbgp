module Message
  # Handles serializing init messages
  class Init

    attr_reader :appid, :idekey, :session, :thread, :parent, :language,
                :protocol_version, :fileuri

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

    def to_xml
      %(<init appid="#{appid}"
      idekey="#{idekey}"
      session="#{session}"
      thread="#{thread}"
      parent="#{parent}"
      language="#{language}"
      protocol_version="#{protocol_version}"
      fileuri="#{fileuri}">)
    end
  end
end
