class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.integer :boiler_id, null: false
      t.string :path, null: false
      t.string :uri, null: false
      t.string :datatype, null: false, default: 'i'
      t.boolean :important, null: false, default: false

      t.timestamps null: false
    end
  end
end
