class CreateDatalogs < ActiveRecord::Migration
  def change
    create_table :datalogs do |t|
      t.references :boiler, index: true, foreign_key: true
      t.text :dataset
      t.text :errorset

      t.timestamps null: false
    end
  end
end
