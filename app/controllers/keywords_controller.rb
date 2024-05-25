class KeywordsController < ApplicationController
    # Before the action, check if user is logged in.
    before_action :require_login, only: [:index]

    # index is a public page
    def index
        if params[:query].present?
            @keywords = Keyword.where("user_id = ? AND keyword ILIKE ?", session[:user_id], "%#{params[:query]}%")
        else
            @keywords = Keyword.where(user_id: session[:user_id])
        end   
    end
  end