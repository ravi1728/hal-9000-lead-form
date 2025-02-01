class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :cp_configs do |t|
      t.integer :channel_partner_id, null: false
      t.string :campaign_id, null: false
      t.integer :project_id, null: false
      t.string :project_name, null: false
      t.string :link, null: false
      t.string :phone, null: false
    end
  end
end
