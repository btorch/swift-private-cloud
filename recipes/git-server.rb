#
# Cookbook Name:: swift-private-cloud
# Recipe:: git-server
#
# Copyright 2012, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node["platform_family"]
when "rhel"
  include_recipe "git::server"
when "debian"
  # git::server is currently borken on debian see: http://tickets.opscode.com/browse/COOK-3433
  # While waiting for fix, do it manually here:
  include_recipe "git"
  package "xinetd" do
    options node["swift-private-cloud"]["common"]["pkg_options"]
  end

  directory node["git"]["server"]["base_path"] do
    owner "root"
    group "root"
    mode 00755
  end

  template "/etc/xinetd.d/git" do
    backup false
    source "git-xinetd.d.erb"
    owner "root"
    group "root"
    mode 00644
  end

  service "xinetd" do
    action [:enable, :restart]
  end
end
