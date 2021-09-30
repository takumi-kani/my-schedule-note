class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :place, null: false
      t.text :info, null: false
      t.references :user ,foreign_key: true
      t.references :admin ,foreign_key: true
      t.timestamps
    end
  end
end
