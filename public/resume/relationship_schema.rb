class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.column "user_id", :integer, :null => false
      t.column "other_user_id", :integer, :null => false
      t.column "created_at", :datetime
      t.column "type", :string, :null => false
    end
  end

  def self.down
    drop_table :relationships
  end
end

