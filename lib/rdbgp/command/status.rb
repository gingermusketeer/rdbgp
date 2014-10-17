module Command
  # Handles validating status commands
  class Status
    attr_reader :parameters

    def initialize(parameters)
      @parameters = parameters
    end

    def valid?
      errors.push("Flag: '-i' is missing") if @parameters.flags[:i].nil?
      errors.empty?
    end

    def errors
      @errors ||= []
    end
  end
end
