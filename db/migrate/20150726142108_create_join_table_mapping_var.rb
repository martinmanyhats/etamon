class CreateJoinTableMappingVar < ActiveRecord::Migration
  def change
    create_join_table :Mappings, :Vars do |t|
      t.index [:mapping_id, :var_id]
      t.index [:var_id, :mapping_id]
    end
  end
end
