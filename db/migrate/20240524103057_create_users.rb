class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.datetime :last_signin_at

      t.timestamps
    end
  end
end
