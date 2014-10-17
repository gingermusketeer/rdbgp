require_relative '../command_base'

module Command
  # Handles validation of feature_set commands of the form
  #  feature_set -i 1 -n feature_name -v feature_value
  class FeatureSet < CommandBase
    def valid?
      validate_flags_present(:i, :n, :v)
      errors.empty?
    end
  end
end
