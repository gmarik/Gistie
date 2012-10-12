require 'bundler'
require 'bundler/setup'
require 'rugged'
require 'sinatra'

class App < Sinatra::Base
  configure do
    enable :inline_templates
  end

  get '/' do
    repo = Rugged::Repository.new(File.dirname(__FILE__))
    commit = repo.lookup(repo.head.target)
    @entries = commit.tree.map do |entry|
      [entry[:name], Rack::Utils.escape_html(repo.read(entry[:oid]).data)]
    end

    erb :view
  end
end


__END__
@@ view
  <% @entries.each do |n, data| %>
   <h2><%= n %></h2>
   <pre><%= data %></pre>
  <% end %>
