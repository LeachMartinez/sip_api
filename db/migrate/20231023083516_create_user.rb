class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, prescence: true
      t.string :password_digest
      t.string :email
      t.string :avatar
      t.string :first_name, prescence: true
      t.string :last_name

      t.timestamps
    end
  end
end
