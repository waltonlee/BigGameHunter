on_worker_boot do
  # ...
  if defined?(Resque)
     Resque.redis = ENV["REDISTOGO_URL"]
  end
end
