class UploadWorker
  include Sidekiq::Worker
  require 'csv'

  def perform(transaction_csv_path, id)
		current_merchant = Merchant.find_by(mapping_id: id)
		old_users = current_merchant.users.count
    @transactions = 0
    csv_text = CSV.foreach(transaction_csv_path, headers: true) do |row|
    	user = User.find_by(mobile: row[0])
			payment_type = PaymentType.find_by(mode: row[3])
			if user.present? && payment_type.present?
				t =	current_merchant.transactions.create!(user: user, amount_spent: row[1], payment_type: payment_type, bill_number: row[2])
				@transactions = (@transactions + 1) if t
				p t
			end
		end
		updated_users = current_merchant.users.count
  	new_users = updated_users - old_users
  	$redis.set("old_users_count", old_users)
  	$redis.set("old_transactions_count", current_merchant.transactions.count)
  	$redis.set("new_users_count", new_users)
  	$redis.set("new_transactions_count", @transactions)
    # Start re-caching the values
    data = Transaction.where(created_at: (Date.current - 14.days)..Date.current).order('created_at DESC')
    $redis.set('weekly_transaction', data.to_json)

    data = Transaction.where(created_at: (Date.current - 60.days)..Date.current).order('created_at DESC')
    $redis.set('monthly_transaction', data.to_json)

    data = Transaction.where(created_at: (Date.current - 2.year)..Date.current).order('created_at DESC')
    $redis.set('yearly_transaction', data.to_json)

  	InformMailer.data_uploaded(email, new_users, @transactions)
  end
end
