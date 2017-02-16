require './lib/dictionary'

class Router
  attr_accessor :game

  def initialize
    @game = nil
  end

  def reply(diag_hash, counter)
    respnse = ""
    if diag_hash["Verb"] == "GET"
      response = get_from_server(diag_hash, counter)
    end
    response
  end

  def get_from_server(diag_hash, counter)
    response = ""
    if diag_hash["Path"] == "/hello"
      response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
    elsif diag_hash["Path"] == "/datetime"
      response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
    elsif diag_hash["Path"] == "/shutdown"
      response = "Number of Ping Requests: #{counter}"
    elsif diag_hash["Path"] == "/word_search"
      response = in_websters(diag_hash["Value"])
    elsif diag_hash["Path"] == "/joke_time"
      response = "once there was a puddle named Fred! "
    else
      response << "<pre>"
      diag_hash.each do |key, value|
        response << "#{key} : #{value}\n"
      end
      response << "</pre>"
    end
    # response
  end

  def run_websters(guess)
    Dictionary.new.find_word(guess)
  end

  def in_websters(guess)
    match = ""
    if run_websters(guess)
      match = "Yup! #{guess.capitalize} is a word"
    else
      match = "Nope! #{guess.capitalize} is not a word"
    end
  end

end
