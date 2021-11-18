class ChangeRelatiohshipsToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_table :relatiohships, :relationships
  end
end
