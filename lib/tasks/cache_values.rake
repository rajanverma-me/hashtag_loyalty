namespace :cache_values do
  desc "TODO"
  task weekly_transaction: :environment do
    data = Transaction.where(created_at: (Date.current - 14.days)..Date.current).sort('created_at DESC').group(:created_at).count
    $redis.set('weekly_transaction', data.to_json)
  end

  desc "TODO"
  task monthly_transaction: :environment do
    data = Transaction.where(created_at: (Date.current - 60.days)..Date.current).sort('created_at DESC').group(:created_at).count
    $redis.set('monthly_transaction', data.to_json)
  end

  desc "TODO"
  task yearly_transaction: :environment do
    data = Transaction.where(created_at: (Date.current - 365.days)..Date.current).sort('created_at DESC').group(:created_at).count
    $redis.set('yearly_transaction', data.to_json)
  end

  desc "TODO"
  task weekly_users: :environment do
  end

  desc "TODO"
  task daily_users: :environment do

  end

  desc "TODO"
  task yearly_users: :environment do
  end

  desc "TODO"
  task weekly_revenue: :environment do
  end

  desc "TODO"
  task monthly_revenue: :environment do
  end

  desc "TODO"
  task yearly_revenue: :environment do
  end

end
