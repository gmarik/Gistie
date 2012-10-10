require 'bundler'
require 'bundler/setup'
require 'rugged'
require 'sinatra'

class App < Sinatra::Base
  get '/' do
    repo = Rugged::Repository.new(File.dirname(__FILE__))
    commit = repo.lookup(repo.head.target)
    text = commit.tree.map { |entry| entry[:name] }.join("\n")
    html = <<-HTML
    <pre>
      #{text}
    </pre>
    HTML
  end
end
