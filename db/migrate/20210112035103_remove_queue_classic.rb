class RemoveQueueClassic < ActiveRecord::Migration[5.1]
  def up
    execute <<~EOSQL
      DROP TRIGGER queue_classic_notify ON queue_classic_jobs;
      DROP FUNCTION queue_classic_notify();
      DROP FUNCTION lock_head(varchar, integer);
      DROP FUNCTION lock_head(varchar);
      DROP TABLE queue_classic_jobs;
    EOSQL
  end
end
