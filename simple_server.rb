require 'webrick'
require 'json'

class PrintServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    return if req.body.nil?

    result = JSON.parse(req.body)
    puts "///////////// request.body ////////////////\n"
    p req.body
    puts "///////////// request.body(json) ////////////////\n"
    p result
    puts "///////////// response.body ////////////////\n"
    p res.body
  end

  def do_POST(req, res)
    return if req.body.nil?

    result = JSON.parse(req.body)
    puts "///////////// request.body ////////////////\n"
    p req.body
    puts "///////////// request.body(json) ////////////////\n"
    p result
    puts "///////////// response.body ////////////////\n"
    p res.body
  end
end

srv = WEBrick::HTTPServer.new(
  :DocumentRoot => "./",
  :Port => 8000
)

srv.mount("/", PrintServlet)
srv.mount("/osc/info", PrintServlet)
srv.mount("/osc/state", PrintServlet)
srv.mount("/osc/commands/execute", PrintServlet)
trap("INT"){ srv.shutdown }
srv.start
