#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
directory "/tmp/databags"

cookbook_file '/tmp/databags/user1.json' do
  source 'user1.json'
  mode '0755'
  action :create
end

execute 'databag_creation' do
  command 'knife data bag create admins'
end

bash 'upload databags' do
  code <<-EOH
   knife data bag from file admins /tmp/databags --all
  EOH
end

admins = data_bag('admins')

admins.each do |login|
  admin = data_bag_item('admins', login)
  home = "/home/#{login}"

  user(login) do
    manage_home true
  end

end

