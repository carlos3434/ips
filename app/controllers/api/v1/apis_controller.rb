require 'redis'
module Api
    module V1
      class ApisController < ApplicationController

        # GET /top100
        def top100

          redis = Redis.new()

          ips_array = []
          i =0
          list = redis.keys('*')
          redis.keys('*').each do |x|
            ips_array.push( { x =>  redis.get(x.to_s)   } )
             i = i+1
          end

          ips_array = ips_array.sort { |a,b| a.length <=> b.length }.take(1)

          render json:{ ips:ips_array }.as_json
        end
  
        # POST /store_ip
        def request_handler

          redis = Redis.new()


          if redis.get(client_ip)
            redis.set(client_ip, redis.get(client_ip).to_i+1 )
          else 
            redis.set(client_ip, 1 )
          end

          render json: {ip:client_ip,count:redis.get(client_ip)}.as_json

        end
  
        # PUT /clear
        def clear
          redis = Redis.new()
          redis.keys('*').each do |x|
            redis.del(x)
          end
          render json: {status:'ok'}.as_json
        end
  
        private def client_ip
            request.remote_ip
          # '127.5.5.5'
        end

      end
    end
  end
  