require 'ipaddr'

class SubnetFormatValidator < ActiveModel::Validator
  def validate(record)
    @record = record

    validate_dhcp_range
  rescue ArgumentError
    ip_argument_error
  end

  private

    def network_address_prefix
      options[:network_address_prefix] || @record.network_address_prefix
    end

    def subnet_mask
      options[:subnet_mask] || @record.subnet_mask
    end

    def dhcp_range_start
      options[:dhcp_range_start] || @record.dhcp_range_start
    end

    def dhcp_range_stop
      options[:dhcp_range_stop] || @record.dhcp_range_stop
    end

    def ip
      IPAddr.new "#{ network_address_prefix }/#{ subnet_mask }"
    end

    def validate_dhcp_range
      ip_to_validate = ip

      unless ip_to_validate.include?(dhcp_range_start) and ip_to_validate.include?(dhcp_range_stop)
        dhcp_range_error(ip_to_validate)
      end
    end

    def ip_argument_error
      @record.errors[:base] << (options[:message] || "is an invalid ip")
    end

    def dhcp_range_error(invalid_ip)
      @record.errors[:base] << (options[:message] ||
        "has an invalid DHCP range, valid range: #{ invalid_ip.to_range.first } to #{ invalid_ip.to_range.last }")
    end
end
