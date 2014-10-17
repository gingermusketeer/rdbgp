require_relative 'command/status'
require_relative 'command_parser'

# Handles parsing a command and creating the associated command object
class CommandFactory
  class << self
    def build(raw_command)
      parameters = CommandParser.parse(raw_command)
      Command::Status.new(parameters)
    end
  end
end
