class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :pages
      t.string :genres
      t.integer :year
      t.string :ISBN
      t.float :price
    end
  end
end
