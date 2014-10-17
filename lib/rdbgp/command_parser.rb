require 'ostruct'
require 'base64'

# Handles parsing commands of the form
#   command [SPACE] [arguments] [SPACE] -- base64(data) [NULL]
# See http://xdebug.org/docs-dbgp.php#ide-to-debugger-engine-communications
class CommandParser
  class << self
    def parse(raw_opts)
      options = OpenStruct.new
      name_and_args, raw_data = separate_data(raw_opts)
      parts = name_and_args.split
      options.command_name = parts.first.to_sym
      options.flags = hashify_flags(parts[1..-1])
      options.data = decode_data(raw_data)
      options
    end

    private

    def separate_data(raw_opts)
      raw_opts.delete("\x00").split('--')
    end

    def decode_data(raw_data)
      Base64.decode64(raw_data.strip) unless raw_data.nil?
    end

    def hashify_flags(flag_array)
      hash = {}
      flag_array.each_slice(2).each do |group|
        hash[flag_name_to_sym(group.first)] = group.last.tr('"', '')
      end
      hash
    end

    def flag_name_to_sym(raw_flag_name)
      raw_flag_name.delete('-').to_sym
    end
  end
end
