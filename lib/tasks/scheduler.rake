namespace :scheduler do
  desc 'Called by the Heroku scheduler add-on to perform queue_classic jobs'
  task :work => :environment do
    Rails.logger.info ENV.inspect
    Rails.logger.info ActionMailer::Base.smtp_settings.inspect
    QC::Worker.new.work while QC.count > 0
  end
end
