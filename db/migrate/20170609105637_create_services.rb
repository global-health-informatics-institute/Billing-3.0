class CreateServices < ActiveRecord::Migration
  def change
    create_table :services, :primary_key => :service_id do |t|
      t.string :name, null: false
      t.integer :service_type_id, null: false
      t.boolean :voided, default: false
      t.integer :voided_by
      t.string :voided_reason
      t.date :voided_date
      t.timestamps null: false
    end
  end
end
