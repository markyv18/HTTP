require 'socket'
require './lib/parser'
require './lib/router'

class Server
  attr_reader :counter, :router

  def initialize
    tcp_server = TCPServer.new(9292)
    @counter = 1
    @running = true
    @router = Router.new
    runner(tcp_server)
  end

  def runner(tcp_server)
    until @running == false
      starter(tcp_server)
      parser
      outputs
    end
  end

  def starter(tcp_server)
    @client = tcp_server.accept
    puts "Ready for request"
    @request_lines = []
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def parser
    parser = Parser.new
    parser.parse(@request_lines)

    # if router
    #    @response = router.response(parser.diagnostics, counter)
    #  else
    #    @router = Router.new
       @response = @router.reply(parser.diagnostics, counter)
    #  end
     if @response.include?("Number")
       @running = false
     end
   end

  def outputs
    @counter += 1
    html = "<html><head></head><body>#{@response}</body></html>"
    time =       ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{html.length}\r\n\r\n"].join("\r\n")
    @client.puts time
    @client.puts html
    @client.close
  end
end

if __FILE__ == $0
  Server.new
end
