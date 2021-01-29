class CreateM2mhubExternalEvents < ActiveRecord::Migration
  def up
    create_table :m2mhub_external_events, :force => true do |t|
      t.references :status
      t.string :source
      t.text :json_data
      t.text :request_header
      t.references :delayed_job
      t.references :delayed_job_status
      t.text :delayed_job_log
      t.string :delayed_job_method
      t.timestamps
    end
  end

  def down
    drop_table :m2mhub_external_events
  end
end