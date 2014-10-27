require 'byebug'
require 'socket'
require_relative '../rdbgp/command_factory'
module Inspector
  #
  # Interface class for remote use of byebug.
  #
  class RemoteInterface < Byebug::Interface
    def initialize
      super()
      @socket = TCPSocket.new 'localhost', 9000
    end

    def close
      @socket.close
    rescue IOError
    end

    def read_command
      @buffer ||= ''
      while @buffer += @socket.sysread(1000) # Read lines from socket
        if @buffer["\x00"]
          raw_command = @buffer[0..@buffer.index("\x00")]
          @buffer.delete!(raw_command)
          return CommandFactory.build(raw_command)
        end
      end
    end

    def send_message(message)
      @socket.write(message.to_s)
    end

  end
end
