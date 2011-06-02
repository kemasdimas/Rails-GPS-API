class CreateDatabase < ActiveRecord::Migration
  def self.up
    create_table "devices", :force => true do |t|
      t.string  "device_code", :limit => 20,                    :null => false
      t.boolean "logged_in",                 :default => false, :null => false
    end
  
    create_table "gps_statuses", :force => true do |t|
      t.float     "latitude"
      t.float     "longitude"
      t.timestamp "time"
      t.float     "speed"
      t.float     "course"
      t.integer   "device_id",  :null => false
      t.timestamp "created_at"
    end
  end

  def self.down
    drop_table :gps_statuses
    drop_table :devices
  end
end
