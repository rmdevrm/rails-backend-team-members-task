class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
