class KeywordsController < ApplicationController
    # index is a public page
    def index
    end
  
    # secret is a private page, only logged-in user can enter
    def secret
      if current_user.blank?
        render plain: '401 Unauthorized', status: :unauthorized
      end
    end
  end