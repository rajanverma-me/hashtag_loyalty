class DashboardController < ApplicationController
  before_action :authenticate_merchant!
  
  def index
  	@users_count = $redis.get('new_users_count').to_i -  $redis.get('old_users_count').to_i
  	@transactions_count = $redis.get('new_transactions_count').to_i - $redis.get('old_transactions_count').to_i
  	@revenue  =  @users_count * current_merchant.transactions.pluck(:amount_spent).sum
  end

  def transactions
  	duration = params[:duration]
  	case duration
  	when "today"
  		
  	when "Weekly"
  		_data = $redis.get('weekly_transaction')
  		transactions =  JSON.parse(_data)
      # Date labels
      @weekdays1 = ((Date.today-7.days)..Date.today)
      @weekdays2 = (Date.today-14.days)..(Date.today-7.days)
  		current_merchant_transactions = transactions.select {|k| k["merchant_id"] == current_merchant.mapping_id}
      current_merchant_transactions.group_by{ |s| Date.parse s["created_at"] }
      @week_wise_data = d.map{ |t,v| v.count }  
      @period1 = data[0..6]
      @period2 = data[7..13]
  	when "Monthly"
  		_data = $redis.get('monthly_transaction')
  		transactions =  JSON.parse(_data)
      # Month labels by date
      @weekdays1 = ((Date.today-1.month)..Date.today)
      @weekdays2 = (Date.today-2.month)..(Date.today-1.month)
      current_merchant_transactions = transactions.select {|k| k["merchant_id"] == current_merchant.mapping_id}
      current_merchant_transactions.group_by{ |s| Date.parse s["created_at"] }
      data = d.map{ |t,v| v.count }
      @period1 = data[0..29]
  	  @period2 = data[30..59]
    when "Yearly"
      _data = $redis.get('yearly_transaction')
  		transactions = JSON.parse(_data)
      @weekdays1 = ((Date.today-1.year)..Date.today)
      @weekdays2 = (Date.today-2.year)..(Date.today-1.year)
      current_merchant_transactions = transactions.select {|k| k["merchant_id"] == current_merchant.mapping_id}
      current_merchant_transactions.group_by{ |s| Date.parse s["created_at"] }
      @week_wise_data = d.map{ |t,v| v.count }  
      @period1 = data[0..364]
      @period2 = data[365..729]
  	end
  end
end
