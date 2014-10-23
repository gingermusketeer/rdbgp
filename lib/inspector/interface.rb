require 'byebug'

module Inspector
  #
  # Interface class for standard byebug use.
  #
  class Interface < Byebug::Interface
    # def initialize(socket)
    #   super()
    #   @socket = socket
    # end
    #
    # def close
    #   @socket.close
    # rescue IOError
    # end

    def read_command(prompt)
      readline(prompt, true)
    end

    def confirm(prompt)
      readline(prompt, false)
    end

    def puts(*args)
      STDOUT.puts(*args)
    end

    def close
    end

    private

    def readline(prompt, hist)
      puts "READING LINE"
      line = Readline.readline(prompt, false)
    rescue Interrupt
      puts('^C')
      retry
    end
  end
end
require 'socket'
require_relative '../rdbgp/message/init'
require_relative '../rdbgp/command_factory'
module Inspector
  #
  # Interface class for remote use of byebug.
  #
  class RemoteInterface < Interface
    def initialize
      super()
      @socket = TCPSocket.new 'localhost', 9000
      send_init
    end

    def close
      @socket.close
    rescue IOError
    end

    def confirm(prompt)
      raise 'cannot confirm'
      send_command "CONFIRM #{prompt}"
    end

    def read_command(prompt)
      Kernel.puts 'reading command'
      @buffer ||= ''
      while @buffer += @socket.sysread(1000) # Read lines from socket
        puts @buffer
        if @buffer["\x00"]
          raw_command = @buffer[0..@buffer.index("\x00")]
          @buffer.delete!(raw_command)
          puts raw_command         # and print them
          puts CommandFactory.build(raw_command).inspect
        end
      end
      puts 'ending readline'

      # send_command "PROMPT #{prompt}"
    end

    # def puts(message)
    #   puts('putsing', message)
    # end

    private

    def send_init
      Kernel.puts 'sending init'
      init = Message::Init.new(
        appid: 'TEST',
        idekey: 'TEST',
        session: 'TEST',
        thread: 'TEST',
        parent: 'TEST',
        language: 'Ruby',
        protocol_version: '1.0',
        fileuri: 'file://something.rb'
      )
      @socket.write(init.to_s)
    end

    # def send_command(msg)
    #   @socket.puts msg
    #   result = @socket.gets
    #   fail IOError unless result
    #   result.chomp
    # end
  end
end
#
# require 'socket'
# require_relative './lib/rdbgp/message/init'
# require_relative './lib/rdbgp/command_factory'
# s = TCPSocket.new 'localhost', 9000
# init = Message::Init.new(
# appid: 'TEST',
# idekey: 'TEST',
# session: 'TEST',
# thread: 'TEST',
# parent: 'TEST',
# language: 'Ruby',
# protocol_version: '1.0',
# fileuri: 'file://something.rb'
# )
# s.write(init.to_s)
#
# s.close             # close socket when done
