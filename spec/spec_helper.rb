require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'active_model'
require 'subnet_format'

class FakeModelBase
  include ActiveModel::Validations

  attr_accessor :network_address_ip, :gateway_ip, :dhcp_range_start,
                :dhcp_range_stop, :subnet_mask

  def initialize(attrs = {})
    self.network_address_ip = attrs[:network_address_ip]
    self.gateway_ip         = attrs[:gateway_ip]
    self.dhcp_range_start   = attrs[:dhcp_range_start]
    self.dhcp_range_stop    = attrs[:dhcp_range_stop]
    self.subnet_mask        = attrs[:subnet_mask]
  end
end

class FakeModel < FakeModelBase
  validates_with SubnetFormatValidator
end

class FakeModelWithValidationOptions < FakeModelBase
  validates_with SubnetFormatValidator, network_address_ip: '1.2.3.4'
end
