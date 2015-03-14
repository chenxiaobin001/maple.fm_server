Rack::Attack.blacklisted_response = lambda do |env|
  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 403 for blacklists by default
  [ 503, {}, ['{"error":["Too much request, try it after 20s."]}']]
end

Rack::Attack.throttled_response = lambda do |env|
  # name and other data about the matched throttle
  body = [
      env['rack.attack.matched'],
      env['rack.attack.match_type'],
      env['rack.attack.match_data']
  ].inspect

  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 429 for throttling by default
  [ 503, {}, ['{"error":["Too much request, try it after 20s."]}']]
end

Rack::Attack.throttle('logins/ip1', :limit => 5, :period => 20.seconds) do |req|
  if req.path == '/users/sign_in' && req.post?
    req.ip
  end
end

Rack::Attack.throttle('signUp/ip', :limit => 2, :period => 20.seconds) do |req|
  if req.path == '/users/sign_up.json' && req.post?
    req.ip
  end
end

Rack::Attack.throttle('signUp1/ip', :limit => 2, :period => 20.seconds) do |req|
  if req.path == '/users/sign_up' && req.post?
    req.ip
  end
end

Rack::Attack.throttle('signUp1/ip', :limit => 2, :period => 20.seconds) do |req|
  if req.path == '/users/sign_up.json' && req.post?
    req.ip
  end
end

Rack::Attack.throttle('newPost/ip', :limit => 1, :period => 20.seconds) do |req|
  if req.path == '/articles.json' && req.post?
    req.ip
  end
end

Rack::Attack.throttle('newPost1/ip', :limit => 1, :period => 20.seconds) do |req|
  if req.path == '/articles' && req.post?
    req.ip
  end
end