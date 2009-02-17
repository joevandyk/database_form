class CreateFileTable < ActiveRecord::Migration
  def self.up
    create_table :form_files do |t|
      t.column :size, :integer 
      t.column :content_type, :string
      t.column :filename, :string
      t.column :created_at, :datetime
      t.column :form_response_id, :integer
      t.column :response_field, :string
    end
  end

  def self.down
    drop_table :form_files
  end
end
