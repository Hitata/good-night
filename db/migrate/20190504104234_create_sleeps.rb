class CreateSleeps < ActiveRecord::Migration[5.2]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false
      t.date :date, null: false
      t.datetime :clockin_at
      t.datetime :clockout_at
      t.timestamps

      t.index %i[user_id date], unique: true
    end
  end
end
