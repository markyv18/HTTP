class Parser
  attr_reader :diagnostics

  def initialize
    @diagnostics = {"Verb" => "", "Path" => "", "Parameter" => "", "Value" => "",
                    "Protocol" => "", "Host" => "", "Port" => "", "Origin" => "", "Accept" => ""}
  end

  def parse(request_lines)
    split_first_input(request_lines[0])
    if @diagnostics["Verb"] == "POST" && diagnostics["Path"] == "/game"
        @diagnostics["Value"] = request_lines[5].split[1]
    end
    host(request_lines[1])
    format_accept(request_lines[6..8])
  end

  def split_first_input(first_line)
    split_line = first_line.split(" ")
     @diagnostics["Verb"] = split_line[0]
     if split_line[1].include?("?")
       @diagnostics["Path"] = split_line[1].split("?")[0]
       @diagnostics["Parameter"] = split_line[1].split("?")[1].split("=")[0]
       @diagnostics["Value"] = split_line[1].split("?")[1].split("=")[1]
     else
       @diagnostics["Path"] = split_line[1]
     end
     @diagnostics["Protocol"] = split_line[2]
  end

  def host(host_line)
    @diagnostics["Host"] = host_line.split(":")[1][1..-1]
    @diagnostics["Port"] = host_line.split(":")[2]
    @diagnostics["Origin"] = host_line.split(":")[1][1..-1]
  end

  def format_accept(last_three_lines)
    last_three_lines_split = last_three_lines.map do |line|
      line.split(":")
    end
    string = []
    last_three_lines_split.each do |i|
    string << i[1]
    end
    @diagnostics["Accept"] = string.join(", ").strip
  end

  def return_diagnostics
    @diagnostics
  end

end



























#
