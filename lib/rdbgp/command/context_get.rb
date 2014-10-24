require_relative '../command_base'

module Command
  # Handles validating status commands
  class ContextGet < CommandBase
    def valid?
      validate_flags_present(:i)
      validate_flags_present(:d)
      errors.empty?
    end
  end
end
