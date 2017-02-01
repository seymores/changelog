module StatusesHelper

  def current_url(new_params)
    url_for params.permit!.merge(new_params)
  end

end
