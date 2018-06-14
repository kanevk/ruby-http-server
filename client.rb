#! /usr/bin/ruby
require 'socket'

s = TCPSocket.new '127.0.0.1', 8000
s.write "GET /response.txt HTTP/1.0\n"
s.write "\n"
s.close_write

puts s.read
