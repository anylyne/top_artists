Rails.application.routes.draw do
	resources :artists, only: [:index, :show], param: :name
	root "artists#index"
end
