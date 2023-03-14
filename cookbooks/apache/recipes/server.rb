#
# Cookbook:: apache
# Recipe:: server
#
# Copyright:: 2023, The Authors, All Rights Reserved.

package 'httpd'

# file '/var/www/html/index.html' do
#   content <<~HTML
#     <h1>Hello, World!</h1>
#     <h2>Platform: #{node['platform']}</h2>
#     <h2>Hostname: #{node['hostname']}</h2>
#     <h2>Memory  : #{node['memory']['total']}</h2>
#     <h2>CPU Mhz : #{node['cpu']['0']['mhz']}</h2>
#   HTML
# end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  # owner 'root'
  # group 'root'
  # mode '0755'
  # action :create
end

service 'httpd' do
  action [:enable, :start]
end
