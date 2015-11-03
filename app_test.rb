require 'sinatra'

# name of this class will go into the config.ru file
# that controls the rack application server
class MyFoo < Sinatra::Base
  
  # get = method provided by the Sinatra::Base class
  # get '/' matches an HTTP GET request to the root '/' URI
  # example: GET '/' HTTP/1.1 or something similar
  get '/' do
    return "<!DOCTYPE html><html><head></head><body><h1>Goodbye World</h1></body></html>"
  end
end
