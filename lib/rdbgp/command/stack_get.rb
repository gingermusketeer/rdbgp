require_relative '../command_base'
module Command

  class StackGet < CommandBase
    def valid?
      validate_flags_present(:i)
      errors.empty?
    end
  end
end
