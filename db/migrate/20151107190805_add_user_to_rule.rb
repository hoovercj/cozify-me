class AddUserToRule < ActiveRecord::Migration
  def change
    add_reference :rules, :user, index: true, foreign_key: true
  end
end
