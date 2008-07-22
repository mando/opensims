class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string      :name
      t.integer     :country_id
      t.string      :lat
      t.string      :long
      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
