class CreateTableReview < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :station_id
      t.string :review
    end
  end
end
