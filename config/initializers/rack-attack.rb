class Rack::Attack


  blacklist('block 115.236.75.201') do |req|
     '115.236.75.201' == req.ip
     '199.115.117.212' == req.ip
     '199.46.124.12' == req.ip
  end

end
