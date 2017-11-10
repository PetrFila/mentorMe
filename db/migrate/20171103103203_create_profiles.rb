class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|

      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :skill
      t.text :about

      t.timestamps
      t.integer "user_id"
      t.index ["user_id"], name: "index_profiles_on_user_id"

    end
  end
end
