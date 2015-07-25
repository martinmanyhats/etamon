class CreateBoilers < ActiveRecord::Migration
  def change
    create_table :boilers do |t|
      t.string :name, null: false
      t.string :shortname, null: false
      t.string :ipaddress, null: false
      t.integer :port, null: false, default: 8080
      t.boolean :logging, null: false, default: true

      t.timestamps null: false
    end
  end
end
