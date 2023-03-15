#
# Cookbook:: mychef_client
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
if platform?('windows')
  chef_client_scheduled_task 'Run as a scheduled task' do
    frequency 'minute'
    frequency_modifier 30
    action :add
  end
else
  chef_client_cron 'Run as a cron job' do
    minute '0,30'
    hour '*'
    action :add
  end
end
