require 'sinatra'
require 'haml'
require 'sass/plugin/rack'
require './skybill'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Sinatra::Application
