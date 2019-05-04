class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :auth, null: false
      t.timestamps

      t.index :auth, unique: true
    end
  end
end
