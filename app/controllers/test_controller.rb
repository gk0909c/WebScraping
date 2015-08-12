require_dependency "GoogleSearch"

class TestController < ApplicationController
  def index
      @results = []
  end
  
  def search 
    @keyword = params[:keyword]
    @results = Services::GoogleSearch.get_result(@keyword)
  end
end
