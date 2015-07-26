class CreateVars < ActiveRecord::Migration
  def change
    create_table :vars do |t|
      t.string :name
      t.references :boiler, index: true, foreign_key: true
      t.datetime :last_set_date

      t.timestamps null: false
    end
  end
end
