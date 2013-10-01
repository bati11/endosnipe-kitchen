#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "yum-priorities" do
  action :install
end

bash "download JPackage" do
  code <<-EOC
    wget http://mirrors.dotsrc.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm -P /tmp/
  EOC
  creates "/tmp/jpackage-release-6-3.jpp6.noarch.rpm"
end

package "jpackage" do
  action :install
  source "/tmp/jpackage-release-6-3.jpp6.noarch.rpm"
  provider Chef::Provider::Package::Rpm
end

package "tomcat7" do
  action :upgrade
  #version "6.0.24-57.el6_4"
end

service "tomcat7" do
  action [ :enable, :start]
  supports :status => true, :restart => true, :reload => true, :version => true
end

service "iptables" do
  action [:disable, :stop]
end

