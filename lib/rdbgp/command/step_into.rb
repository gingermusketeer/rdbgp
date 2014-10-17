require_relative '../command_base'

module Command
  # Handles validating commands of the form
  #  step_into -i 3
  class StepInto < CommandBase
    def valid?
      validate_flags_present(:i)
      errors.empty?
    end
  end
end
