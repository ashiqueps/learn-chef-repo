#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# haproxy_install 'package'

# haproxy_frontend 'http-in' do
#   bind '*:80'
#   default_backend 'server_backend'
# end

# haproxy_backend 'server_backend' do
#   server [
#     'ec2-52-1-71-190.compute-1.amazonaws.com 52.1.71.190:80 maxconn 32',
#     'ec2-44-201-26-6.compute-1.amazonaws.com 44.201.26.6:80 maxconn 32',
#   ]
# end

# haproxy_service 'haproxy' do
#   action [ :enable, :start ]
# end

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'server_backend'
end

web_nodes = search('node', "policy_name:company_web AND policy_group:#{node.policy_group}")
puts 'What is the true value of node.policy_group'
puts "policy_name:company_web AND policy_group:#{node.policy_group}"
puts '___________________________________________________________________'
# ooh okay got it. This node.policy_group will be the policy group of myhaproxy policy file.

server_array = web_nodes.map { |node| "#{node['cloud']['public_hostname']} #{node['cloud']['public_ipv4']}:80 maxconn 32" }

haproxy_backend 'server_backend' do
  server server_array
end

haproxy_service 'haproxy' do
  action [ :enable, :start ]
end

haproxy_service 'haproxy' do
  subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :delayed
end
