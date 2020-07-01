class Api::V1::PreferencesController < Api::BaseController
  def index
    result = Preference.all
    json_response result, :ok
  end
  def find
    r_id = params[:id]
    result = Preference.where("id = '#{r_id}'")
    if !result.exists?
      json_response nil , :ok
    else
      json_response result.first, :ok
    end
  end
  def find_by_key
    key = params[:key]
    result = Preference.where("key = '#{key}'")
    if !result.exists?
      json_response nil, :ok
    else
      json_response result.first, :ok
    end
  end
  def create
    key = params[:key]
    value = params[:value]
    result = Preference.where("key = '#{key}'")
    if result.exists?
      pref = result.first
      pref.value = value
      pref.save
      json_response pref , :ok
    else
      pref = Preference.new
      pref.key = key
      pref.value = value
      pref.save
      json_response pref, :ok
    end
  end
  def update
    p_id = params[:id]
    key = params[:key]
    value = params[:value]
    result = Preference.where("id = '#{p_id}'")
    if result.exists?
      pref = result.first
      pref.key = key
      pref.value = value
      pref.save
      json_response pref , :ok
    else
      json_response nil, :ok
    end
  end
  def delete
    p_id = params[:id]
    result = Preference.where("id = '#{p_id}'")
    if result.exists?
      pref = result.first
      pref.delete
      json_response pref , :ok
    else
      json_response nil, :ok
    end
  end
end

