namespace :scheduler do
  desc 'Called by the Heroku scheduler add-on to perform queue_classic jobs'
  task :work => :environment do
    QC::Worker.new.work while QC.count > 0
  end
end
