class CreateTables < ActiveRecord::Migration

    def change
        create_table :users do |t|
            t.string :username
            t.string :email
            t.string :password
            t.string :firstname
            t.string :lastname
            t.timestamps
        end

        create_table :pins do |t|
            t.string :title
            t.string :user
            t.string :image
            t.string :text
            t.string :comments
            t.string :dates
            t.timestamps
        end


        create_table :comments do |t|
            t.string :user
            t.timestamps
        end

    end

end