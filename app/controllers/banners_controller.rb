class BannersController < ApplicationController
  def track_click
    @banner = Banner.find(params[:id])
    @banner.increment!(:clicks)
    redirect_to @banner.url, allow_other_host: true
  end
end