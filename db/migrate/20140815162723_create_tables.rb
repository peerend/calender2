class CreateTables < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :location
      t.timestamp :start_date
      t.timestamp :end_date
      t.timestamps
    end

    create_table :notes do |t|
      t.string :name
      t.string :body
      t.belongs_to :event
      t.timestamps
    end
  end
end
