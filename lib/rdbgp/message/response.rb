# <response command="run"
#           status="starting"
#           reason="ok"
#           transaction_id="transaction_id"/>

require 'xmlsimple'
require_relative '../message_base'
module Message
  # Handles serializing init messages
  class Response < MessageBase
    attr_reader :response_attrs

    def initialize(response_attrs)
      @response_attrs = response_attrs
    end

    def to_h
      {
        response: { xmlns: xml_namespace }.merge(response_attrs)
      }
    end
  end
end
