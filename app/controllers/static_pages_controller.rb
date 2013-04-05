class StaticPagesController < ActionController::Base
  def index
    render :template => "static_pages/index"
  end
end
