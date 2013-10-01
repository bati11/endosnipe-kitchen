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

template "pg_hba.conf" do
  path "/var/lib/pgsql/data/pg_hba.conf"
  source "pg_hba.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[postgresql]'
end

service "postgresql" do
  action [ :enable, :start]
  supports :status => true, :restart => true, :reload => true
end

bash "set password" do
  code <<-EOC
    su - postgres -c "psql -c \\"alter role postgres with password 'postgres';\\""
  EOC
end

