class CreateDatalogs < ActiveRecord::Migration
  def change
    create_table :datalogs do |t|
      t.references :boiler, index: true, foreign_key: true
      t.text :values
      t.text :errors

      t.timestamps null: false
    end
  end
end
