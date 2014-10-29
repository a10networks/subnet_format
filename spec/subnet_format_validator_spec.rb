describe SubnetFormatValidator do

  let(:network) {
    {
      subnet_mask: '255.255.255.0',
      network_address_prefix: '192.168.0.1',
      dhcp_range_stop: '192.168.0.30',
      dhcp_range_start: '192.168.0.5'
    }
  }

  let(:ten_dot_network) {
    {
      subnet_mask: '255.255.0.0',
      network_address_prefix: '10.0.0.1',
      dhcp_range_stop: '10.0.0.200',
      dhcp_range_start: '10.0.0.10'
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
      expect(FakeModelWithValidationOptions).to_not receive(:network_address_prefix)
      fake_model.valid?
    end

    it 'should still be valid' do
      expect(fake_model.valid?).to be_truthy
    end
  end

  context 'with a 10.X IP' do

    let(:fake_model) { FakeModel.new(ten_dot_network) }

    it { should be_valid }

    context 'with an invalid IP' do

      before { fake_model.dhcp_range_stop = '10.0.0.256' }

      it { should_not be_valid }
    end
  end
end
