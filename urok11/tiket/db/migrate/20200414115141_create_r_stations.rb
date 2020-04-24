class CreateRStations < ActiveRecord::Migration[6.0]
  def change
    create_table :r_stations do |t|
      t.string :title

      t.timestamps
    end
  end
end
