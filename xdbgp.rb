require 'socket'
require_relative './lib/rdbgp/message/init'
require_relative './lib/rdbgp/command_factory'
s = TCPSocket.new 'localhost', 9000
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
s.write(init.to_s)
line = ''
while line += s.sysread(1000) # Read lines from socket
  if line["\x00"]
    raw_command = line[0..line.index("\x00")]
    line.delete!(raw_command)
    puts raw_command         # and print them
    puts CommandFactory.build(raw_command).inspect
  end
end

s.close             # close socket when done
