require_relative '../command_base'

module Command
  # Handles validating commands of the form
  #  run -i 3
  class Run < CommandBase
    def valid?
      validate_flags_present(:i)
      errors.empty?
    end
  end
end
