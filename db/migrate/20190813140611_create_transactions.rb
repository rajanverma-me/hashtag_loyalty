class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount_spent
      t.string :bill_number
      t.references :user, foreign_key: true
      t.references :payment_type, foreign_key: true

      t.timestamps
    end
  end
end
