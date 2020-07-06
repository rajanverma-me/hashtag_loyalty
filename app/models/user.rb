class User < ApplicationRecord
	validates_uniqueness_of :mobile
	has_many :merchants, through: :transactions
end
