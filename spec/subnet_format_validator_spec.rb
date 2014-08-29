require 'spec_helper'

describe SubnetFormatValidator do

  let(:fake_model) { FakeModel.new(
                        subnet_mask: '255.255.255.0',
                        network_address_ip: '192.168.0.1',
                        dhcp_range_stop: '192.168.0.30',
                        dhcp_range_start: '192.168.0.5') }

  subject { fake_model }

  it { should be_valid }
end