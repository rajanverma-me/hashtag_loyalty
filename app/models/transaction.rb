class Transaction < ApplicationRecord
  belongs_to :merchant, primary_key: 'mapping_id', foreign_key: 'merchant_id', class_name: 'Merchant'
  belongs_to :user
  belongs_to :payment_type
end
