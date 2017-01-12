require 'webrick'
require 'json'

class PrintServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    return if req.body.nil?
    print_req_and_res(req, res)
  end

  def do_POST(req, res)
    return if req.body.nil?
    print_req_and_res(req, res)
  end

  private
  def print_req_and_res(req, res)
    result = JSON.parse(req.body)

    p "///////////// request.body ////////////////"
    p req.body
    p "///////////// request.body(json) ////////////////"
    p result
    p "///////////// response.body ////////////////"
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
