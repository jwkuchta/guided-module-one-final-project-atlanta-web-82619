class CreateTableStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string :name
    end
  end
end
