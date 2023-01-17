class DropQue < ActiveRecord::Migration[6.1]
  def up
    drop_table :que_lockers
    drop_table :que_values

    execute 'DROP TRIGGER que_job_notify ON que_jobs'
    execute 'DROP FUNCTION que_job_notify'
    execute 'DROP TRIGGER que_state_notify ON que_jobs'
    execute 'DROP FUNCTION que_state_notify'

    execute <<~EOSQL.squish
      ALTER TABLE que_jobs
        DROP CONSTRAINT error_length,
        DROP CONSTRAINT queue_length,
        DROP CONSTRAINT job_class_length,
        DROP CONSTRAINT valid_args,
        DROP CONSTRAINT valid_data
    EOSQL

    execute 'DROP FUNCTION que_determine_job_state'
    execute 'DROP FUNCTION que_validate_tags'

    drop_table :que_jobs
  end
end
