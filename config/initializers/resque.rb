if Rails.env == 'production'
  require 'redis'
  ENV["REDISTOGO_URL"] ||= "redis://redistogo:50c726316702440b953078266d49d608@viperfish.redistogo.com:11866/"

  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
