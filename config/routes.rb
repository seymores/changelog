Rails.application.routes.draw do

  root 'statuses#index'

  resources :statuses do
    collection do
      get 'query'
      get 'upload'
      post 'upload_csv_file'
    end
    # get 'upload', on: :collection
  end
end
