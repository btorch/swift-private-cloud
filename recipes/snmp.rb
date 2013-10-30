#
# Cookbook Name:: swift-private-cloud
# Recipe:: snmp
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

node["snmp"]["platform"]["packages"].each do |pkg|
  package pkg do
    options node["swift-private-cloud"]["common"]["pkg_options"]
    action :install
  end
end

service node["snmp"]["platform"]["service"] do
  supports :restart => true, :status => true
  action [:enable, :start]
end