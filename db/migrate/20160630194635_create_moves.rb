class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :address
      t.text       :description
      t.timestamps null: false
    end
  end
end
