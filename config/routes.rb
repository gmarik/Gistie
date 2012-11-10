Gitsy::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  #

  # match '/gists/:gist_id/blobs/:id/:filename' => 'blobs#show'


  resources :gists do
    scope format: 'text' do
      match 'blobs/:id/*filename' => 'blobs#show', as: :raw, filename: /.*/, format: false
    end
  end

  root :to => 'gists#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
