class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.text :rule_type
      t.text :name
      t.text :description
      t.text :summary
      t.text :capabilities
      t.text :code

      t.timestamps null: false
    end
  end
end
