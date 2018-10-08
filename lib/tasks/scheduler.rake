desc "This task is called by the Heroku scheduler add-on"
task update_and_notify: :environment do
  Page.pull!
  Page.snapshot!
  DailyRanking.new.notify
end
