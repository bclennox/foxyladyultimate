class CreateCancellations < ActiveRecord::Migration[5.1]
  def up
    execute(<<-EOSQL)
      CREATE VIEW cancellations AS SELECT
        date_trunc('month', starts_at)::date AS date,
        COUNT(CASE WHEN canceled = true  THEN 1 END) AS canceled,
        COUNT(CASE WHEN canceled = false THEN 1 END) AS active
      FROM games
      GROUP BY 1
    EOSQL
  end

  def down
    execute('DROP VIEW cancellations')
  end
end
