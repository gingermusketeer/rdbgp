require_relative 'command/status'
require_relative 'command/feature_set'
require_relative 'command/step_into'
require_relative 'command/stack_get'
require_relative 'command/context_names'
require_relative 'command_parser'

# Handles parsing a command and creating the associated command object
class CommandFactory
  class << self
    def build(raw_command)
      parameters = CommandParser.parse(raw_command)
      class_from_command_name(parameters.command_name).new(parameters)
    end

    def class_from_command_name(command_name)
      upper_camel_case = command_name.to_s.split('_').map do |word|
        word[0].upcase + word[1..-1]
      end.join
      Module.const_get("Command::#{upper_camel_case}")
    end
  end
end
