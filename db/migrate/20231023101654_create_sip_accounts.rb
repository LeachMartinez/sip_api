class CreateSipAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :sip_accounts do |t|
      t.string :username
      t.string :password
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
