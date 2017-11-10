class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :chat, foreign_key: true
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
