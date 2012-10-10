require 'bundler'
require 'bundler/setup'
require 'rugged'
require 'sinatra'

class App < Sinatra::Base

  get '/' do
    repo = Rugged::Repository.new(File.dirname(__FILE__))

    tree = repo.lookup('HEAD')
    tree.map { |entry| puts entry[:name] }.join("\n")

  end

end

run App
