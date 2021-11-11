require 'redis'

class HomeController < ApplicationController
  def index
    redis = Redis.new(client_ip: client_ip)
    redis.set("a", 1000)
    # "OK"
    redis.get("client_ip")

    render plain: "You IP address is #{client_ip} #{redis.get("a")} "
  end

  private def client_ip
    request.remote_ip
  end
  #private def request_handled(ip_address)

  #end
end