require "rubygems"
require "bundler/setup"

require 'sinatra'
require 'sinatra/respond_to'

require 'lib/monitored_project'
require 'lib/greenscreen'

require 'haml'
require 'json'

Sinatra::Application.register Sinatra::RespondTo

helpers do
  def partial(page, options={})
    haml page, options.merge!(:layout => false)
  end
end

before do
  @projects = Greenscreen.projects
end

get '/' do
  haml :index
end

get '/builds' do
  respond_to do |wants|
    wants.html { haml :builds }
    wants.json { @projects.to_json }
  end
end