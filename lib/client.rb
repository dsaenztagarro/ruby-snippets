require "json"
require "socket"

client = { basedir: "/Users/guest/" }

watcheds = [ { id: "rspec", pattern: "./spec/models/*_spec.rb" } ]

raw_message = [client, watcheds].flatten.map(&:to_json).join("\n")

puts raw_message

SERVER_ADDRESS = "/tmp/mazingerz.socket"

begin
  socket = UNIXSocket.new(SERVER_ADDRESS)

  puts "Client socket address: #{socket.addr}"

  socket.send raw_message
rescue Errno::ENOENT => error
  puts error
end
