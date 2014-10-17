require_relative '../command_base'

module Command
  # Handles validating status commands
  class Status < CommandBase
    def valid?
      validate_flags_present(:i)
      errors.empty?
    end
  end
end
