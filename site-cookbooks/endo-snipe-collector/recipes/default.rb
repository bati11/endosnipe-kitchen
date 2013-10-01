#
# Cookbook Name:: endo-snipe
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "unzip" do
  action :install
end

bash "install endo-snipe" do
  code <<-EOC
    wget http://sourceforge.net/projects/endosnipe/files/5.0.4/endosnipe_5.0.4.zip/download -P /opt/
    unzip /opt/endosnipe_5.0.4.zip -d /opt/
    tar zxf /opt/endosnipe-datacollector-5.0.4.tar.gz -C /opt/
    rm /opt/Javelin_5.0.4.zip
    rm /opt/endosnipe-datacollector-5.0.4.zip
    rm /opt/endosnipe-datacollector-5.0.4.tar.gz
    rm /opt/endosnipe_5.0.4.zip
    mv -f /opt/Dashboard.war /usr/share/tomcat7/webapps/
  EOC
  creates "/opt/ENdoSnipe"
  notifies :restart, 'service[tomcat7]'
end

template "collector.properties" do
  path "/opt/ENdoSnipe/DataCollector/conf/collector.properties"
  source "collector.properties.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[tomcat7]'
end

bash "start" do
  environment "JAVA_HOME" => '/usr/lib/jvm/jre'
  code <<-EOC
    /opt/ENdoSnipe/DataCollector/bin/endosnipe-dc start
  EOC
end

