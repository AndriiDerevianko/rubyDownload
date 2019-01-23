# coding: utf-8
 
require "rubygems"
require "rack"
 
require "./server.rb"
 
class Router
 
  include SimpleUpload
 
  def default
    [ 404, {'Content-Type' => 'text/plain'}, ['404 file not found'] ]
  end
 
  def call(env)
    if env['REQUEST_PATH'].match(%r{^/index$}) then return [200, {'Content-Type' => 'text/html'}, [ index(env) ]] end
    if env['REQUEST_PATH'].match(%r{^/upload$}) then return [200, {'Content-Type' => 'text/html'}, [ upload(env) ]] end
    default
  end
end
 
run Router.new()
