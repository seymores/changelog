class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.integer :object_id
      t.string :object_type
      t.timestamp :timestamp
      t.json :state

      t.timestamps
    end
  end
end
