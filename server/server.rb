require 'socket'

module MicroRedis
  class Server
    attr_reader :server

    def initialize
      @server = TCPServer.new('0.0.0.0', 6378)
    end

    def run
      loop do
        Thread.start(server.accept) do |client|
          client.puts 'Hello'
          client.puts "Time is #{Time.now}"
          client.close
        end
      end
    end
  end
end

puts 'Server running on port 6378'

MicroRedis::Server.new.run
