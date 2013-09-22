#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "tomcat6" do
  action :upgrade
  #version "6.0.24-57.el6_4"
end

service "tomcat6" do
  action [ :enable, :start]
  supports :status => true, :restart => true, :reload => true, :version => true
end

service "iptables" do
  action [:disable, :stop]
end

