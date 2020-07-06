class AdminController < ApplicationController
  before_action :authenticate_merchant!
  require 'csv'

  def index
  end

  def upload
  	transaction_csv = params[:transaction_csv]
  	if transaction_csv.presence && (transaction_csv.content_type == "text/csv") 
  		# Transfer file to fixed path in order to load in sidekiq
	  	FileUtils.cp transaction_csv.path, "#{Rails.root}/tmp/new_transactions_temporary.csv"
	  	UploadWorker.perform_async("#{Rails.root}/tmp/new_transactions.csv", current_merchant.mapping_id)
  		redirect_back fallback_location: "/admin", notice: "Your file is set for uploading. You will receive email on completion."
  	end
  end
end
