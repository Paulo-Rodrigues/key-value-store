require 'socket'

module MicroRedis
  class Client
    attr_reader :client

    def initialize
      @client = TCPSocket.new('0.0.0.0', 6378)
    end

    def call
      while line = client.gets
        puts line.chop
      end
      client.close
    end
  end
end

puts 'client...'

MicroRedis::Client.new.call
