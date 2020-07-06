class AddMappingIdToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :mapping_id, :integer
  end
end
