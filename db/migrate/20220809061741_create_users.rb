class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|  # t stands for table
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end

# The change method determines the change to be made to the database. 
# change uses a Rails method called create_table to create a table in the database for storing users.