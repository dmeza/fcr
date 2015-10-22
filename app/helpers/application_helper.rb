module ApplicationHelper
  def clear_search_params(clear_params = [])
    keep_params = [:voluntary_name, :voluntary_id, :email, :start_date, :end_date, :brigade_id, :city_id]
    return params.slice(*(keep_params - clear_params))
  end
end
