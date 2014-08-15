class AddEventName < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
  end
end
