require_relative '../command_base'

module Command
  # Handles validating status commands
  class Source < CommandBase
    def valid?
      validate_flags_present(:i)
      validate_flags_present(:f)
      errors.empty?
    end
  end
end
