#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "postgresql-server" do
  action :install
end

bash "init postgres" do
  code <<-EOC
    /sbin/service postgresql initdb
  EOC
  creates "/var/lib/pgsql/data/base"
end

service "postgresql" do
  action [ :enable, :start]
  supports :status => true, :restart => true, :reload => true
end

