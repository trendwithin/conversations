desc "This task is called by the Heroku scheduler add-on"
task :update_tweets => :environment do
  puts "Fetching Tweets..."
  Chirp.fetch_peeps
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end
