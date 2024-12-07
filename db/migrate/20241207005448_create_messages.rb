class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :enrollment_id
      t.text :body
      t.string :role
      t.integer :score
      t.text :feedback

      t.timestamps
    end
  end
end
