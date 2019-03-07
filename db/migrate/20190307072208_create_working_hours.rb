class CreateWorkingHours < ActiveRecord::Migration[5.2]
  def change
    create_table :working_hours do |t|
      t.string :timezone
      t.integer :start_time_in_minutes_utc
      t.integer :end_time_in_minutes_utc
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
