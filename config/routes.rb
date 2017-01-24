Rails.application.routes.draw do
  resources :statuses do
    collection do
      get 'upload'
      post 'upload_csv_file'
    end
    # get 'upload', on: :collection
  end
end
