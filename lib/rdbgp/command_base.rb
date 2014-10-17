# Base class for all commands
class CommandBase
  attr_reader :parameters

  def initialize(parameters)
    @parameters = parameters
  end

  def validate_flags_present(*flags)
    flags.each do |flag|
      errors.push("Flag: '-#{flag}' is missing") if @parameters.flags[flag].nil?
    end
  end

  def errors
    @errors ||= []
  end
end
