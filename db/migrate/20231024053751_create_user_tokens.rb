class CreateUserTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, prescence: true, null: false
      t.string :user_agent
      t.string :ip
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
