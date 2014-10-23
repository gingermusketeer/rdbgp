require_relative '../command_base'

module Command
  # Handles validating commands of the form
  #  step_into -i 3
  class StepInto < CommandBase
    class << self
      attr_accessor :process_block
    end

    def process
      self.class.process_block.call
    end

    def valid?
      validate_flags_present(:i)
      errors.empty?
    end
  end
end
