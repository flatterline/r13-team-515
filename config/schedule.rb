# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end

set :output, "/home/deploy/apps/wyld-stallyns/current/log/cron_log.log"
env :MAILTO, "irish@burstdev.com"
env :PATH,   "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

# Grab at 6am, 12pm, 5pm
every '0 0,4,8,12,16,20 * * *' do
  rake :fetch_screenshots
end

# Learn more: http://github.com/javan/whenever
