class CreateTutors < ActiveRecord::Migration[6.1]
  def change
    create_table :tutors do |t|
      t.string :first_name
      t.string :last_name
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
