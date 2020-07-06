class Merchant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	self.primary_key = :mapping_id
	has_many :transactions, primary_key: 'mapping_id', foreign_key: 'merchant_id', class_name: 'Transaction'
	has_many :users, through: :transactions
end
