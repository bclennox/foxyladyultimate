ActiveRecord::Base.establish_connection
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:datetime] = 'timestamp with time zone'
