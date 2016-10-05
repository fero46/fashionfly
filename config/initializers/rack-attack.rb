class Rack::Attack


  blacklist('block 115.236.75.201') do |req|
     '115.236.75.201' == req.ip
  end

end
