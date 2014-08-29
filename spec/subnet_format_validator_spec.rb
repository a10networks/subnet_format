describe SubnetFormatValidator do

  let(:network) {
    {
      subnet_mask: '255.255.255.0',
      network_address_ip: '192.168.0.1',
      dhcp_range_stop: '192.168.0.30',
      dhcp_range_start: '192.168.0.5'
    }
  }

  let(:fake_model) { FakeModel.new(network) }

  subject { fake_model }

  it { should be_valid }

  context 'with an invalid subnet mask' do

    let(:invalid_subnet_mask_options) { network.merge(subnet_mask: '123') }

    let(:fake_model) { FakeModel.new(invalid_subnet_mask_options) }

    it 'should be invalid' do
      expect(fake_model.valid?).to be_falsey
    end
  end

  context 'with options passed' do

    let(:fake_model) { FakeModelWithValidationOptions.new(network) }

    it 'should use them rather than the class method' do
      expect(FakeModelWithValidationOptions).to_not receive(:network_address_ip)
      fake_model.valid?
    end
  end
end
