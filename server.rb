#! /usr/bin/ruby
require 'socket'

THREAD_POOL_SIZE = ENV['THREAD_POOL_SIZE'].to_i

# server_socket = Socket.new(
#   Socket::Constants::AF_INET,
#   Socket::Constants::SOCK_STREAM,
#   0
# )
#
# address = Socket.pack_sockaddr_in(8000, '0.0.0.0') # From anywhere
# server_socket.bind(address)
#
# server_socket.listen(1) # number of buffer connections
#
# socket, address = server_socket.accept
# puts address.inspect
#
server_socket = TCPServer.new(8000)

Array.new(THREAD_POOL_SIZE).map do
  Thread.new do
    loop do
      socket = server_socket.accept

      until (line = socket.gets).strip.empty?
        puts line
      end

      # sleep 10 # the parallel execution

      File.open('response.txt', 'r') { |file| IO.copy_stream(file, socket) }
      socket.close_write
    end
  end
end.map(&:join)
