GmapCoordinatesPicker.configure do |config|
  config.lat_column = :latitude
  config.lng_column = :longitude
  config.default_coordinates = [42.4075, -71.1190] #TU
  #config.map_handler = 'gMapObj' #javascript map object
  config.zoom_level = 16
  #config.map_container_class = 'gmap_coordinate_picker_container'
  #config.map_width = '600px'
  #config.map_height = '400px'
end

#API KEY: AIzaSyDJbp32tSbN-En9Zb2eU43iGwPmqp2uYwc