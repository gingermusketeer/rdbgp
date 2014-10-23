require 'byebug'
require_relative './lib/inspector/interface'
require_relative './lib/inspector/command_processor'

module Kernel
  def inspector
    interface = Inspector::RemoteInterface.new
    Byebug.handler = Inspector::CommandProcessor.new(interface)
    byebug(1, false)
  end
end
