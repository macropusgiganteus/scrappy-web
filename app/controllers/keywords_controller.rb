class KeywordsController < ApplicationController
    require 'csv'

    require "httparty" 
    require "nokogiri"

    # Before the action, check if user is logged in.
    before_action :require_login, only: [:index]

    # index is a public page
    def index
        if params[:query].present?
            @keywords = Keyword.includes(:keyword_result).where("user_id = ? AND keyword ILIKE ?", session[:user_id], "%#{params[:query]}%")
        else
            @keywords = Keyword.where(user_id: session[:user_id])
        end   
    end

    def show
        @html_view = "code"
        if params[:id].present? && Keyword.includes(:keyword_result).find_by(user: current_user, id: params[:id]).present?
            if params[:view].present?
                @html_view = params[:view]
            end

            @keyword = Keyword.includes(:keyword_result).find_by(user: current_user, id: params[:id])
        else 
            redirect_to keywords_path
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
        total_created = 0
        begin
            CSV.foreach(file.path) do |row|
                next if Keyword.find_by(user: current_user, keyword: row[0]).present?
                
                keyword = Keyword.new(user: current_user, keyword: row[0])

                if keyword.valid?
                    total_ads, total_links, stats, html = *google_search(keyword.keyword)

                    keyword_result = KeywordResult.new(keyword: keyword, total_ads: total_ads, total_links: total_links, total_search_results: stats, html: html)

                    if keyword_result.valid?
                        keyword.save!
                        keyword_result.save!
                        total_created += 1
                    else 
                        redirect_to keywords_path, notice: "kw_res: #{keyword_result}"
                        return true
                    end 

                else
                    # Handle invalid rows here, e.g., log errors
                    Rails.logger.error "Invalid row: #{keyword.errors.full_messages}"
                end
            end
            if total_created == 0
                redirect_to keywords_path, notice: "No new keywords were found in the CSV file."
            else 
                redirect_to keywords_path, notice: "CSV imported successfully. #{total_created} new keywords were imported"
            end
        rescue CSV::MalformedCSVError => e
            redirect_to keywords_path, alert: "There was an error processing the file: #{e.message}"
        end
    end      

    private 

    def google_search(keyword)
        response = HTTParty.get("http://www.google.com/search?q=#{keyword}&hl=en", { 
            headers: { 
                "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36" 
            }, 
        })

        # parsing the HTML document returned by the server 
        document = Nokogiri::HTML(response.body)

        # defining a data structure to store the scraped data 
        # Result = Struct.new(:url, :image, :name, :price)

        html_ads_section = document.at_css('div#tads[aria-label=Ads]') || document.at_css('div#tads')
        total_ads = html_ads_section ? html_ads_section.count : 0

        # selecting all HTML link elements 
        html_links = document.css("a")
        total_links = html_links.count

        html_stats = document.at_css("div#result-stats")

        return total_ads, total_links, html_stats.content, document
    end
end