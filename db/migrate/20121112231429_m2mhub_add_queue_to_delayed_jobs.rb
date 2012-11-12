class M2mhubAddQueueToDelayedJobs < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :queue, :string
  end

  def self.down
    remove_column :delayed_jobs, :queue
  end
end
