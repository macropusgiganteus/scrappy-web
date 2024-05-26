class KeywordsController < ApplicationController
    require 'csv'
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

    def import_csv    
        if !params[:file].present?
            redirect_to keywords_path, alert: "Please upload a file"
            return true
        end

        file = params[:file]

        if file.content_type != 'text/csv'
            redirect_to keywords_path, alert: "Invalid file type. Please upload a CSV file."
            return true
        end

        total_rows = CSV.read(file.path).count
        if (total_rows == 0)
            redirect_to keywords_path, alert: "The file is empty."
            return true
        elsif (total_rows > 100)
            redirect_to keywords_path, alert: "Keywords exceed 100 rows."
            return true
        end

        # Process the file
        begin
            CSV.foreach(file.path) do |row|
            keyword = Keyword.new
            keyword.keyword = row[0]
            keyword.user = current_user
            
            if keyword.valid?
                keyword.save!
            else
                # Handle invalid rows here, e.g., log errors
                Rails.logger.error "Invalid row: #{keyword.errors.full_messages}"
            end
        end
            redirect_to keywords_path, notice: "CSV imported successfully"
        rescue CSV::MalformedCSVError => e
            redirect_to keywords_path, alert: "There was an error processing the file: #{e.message}"
        end
    end      
end