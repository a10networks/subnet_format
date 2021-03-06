require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'active_model'
require 'subnet_format'

class FakeModelBase
  include ActiveModel::Validations
  include ActiveModel::Serialization

  attr_accessor :network_address_prefix, :gateway_ip, :dhcp_range_start,
                :dhcp_range_stop, :subnet_mask

  def initialize(attrs = {})
    self.network_address_prefix = attrs[:network_address_prefix]
    self.gateway_ip             = attrs[:gateway_ip]
    self.dhcp_range_start       = attrs[:dhcp_range_start]
    self.dhcp_range_stop        = attrs[:dhcp_range_stop]
    self.subnet_mask            = attrs[:subnet_mask]
  end
end

class FakeModel < FakeModelBase
  validates_with SubnetFormatValidator
end

class FakeModelWithValidationOptions < FakeModelBase
  attr_accessor :new_network_address_prefix_attr

  def initialize(attrs = {})
    super
    self.new_network_address_prefix_attr = attrs[:network_address_prefix]
  end

  validates_with SubnetFormatValidator, network_address_prefix: :new_network_address_prefix_attr
end
