require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'active_model'
require 'subnet_format'

class FakeModel
  include ActiveModel::Validations

  attr_accessor :network_address_ip, :gateway_ip, :dhcp_range_start,
                :dhcp_range_stop, :subnet_mask

  validates_with SubnetFormatValidator

  def initialize(attrs = {})
    self.network_address_ip = attrs[:network_address_ip]
    self.gateway_ip         = attrs[:gateway_ip]
    self.dhcp_range_start   = attrs[:dhcp_range_start]
    self.dhcp_range_stop    = attrs[:dhcp_range_stop]
    self.subnet_mask        = attrs[:subnet_mask]
  end
end
