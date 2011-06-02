class CreateGpsStatuses < ActiveRecord::Migration
  def self.up
    create_table :gps_statuses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :gps_statuses
  end
end
