require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def test_it_start_server
    server = Server.new
    assert_equal TCPServer, http.tcp_server.class
  end

  def test_count
    server = Server.new
    assert_equal 0, http.counter
  end

 #  def test_does_faraday_listen?
 #    response = Faraday.get("http://127.0.0.1:9292/")
 #    assert_equal 200, response.status
 # end

 # def test_hello_world
 #  response = Faraday.get("http://127.0.0.1:9292/hello")
 #  assert_equal "<html><head></head><body><pre>Hello, World! (3)</pre></body></html>", response.body
 # end

 # def test_diagnostics
 #  response = Faraday.get("http://127.0.0.1:9292/")
 #  assert response.body
 #  end
 #
 # def test_date_time
 # response = Faraday.get("http://127.0.0.1:9292/datetime")
 # time = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
 # assert response.body.include?(time)
 # end

 end
