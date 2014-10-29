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
      @record.send(options[:network_address_prefix] || :network_address_prefix)
    end

    def subnet_mask
      @record.send(options[:subnet_mask] || :subnet_mask)
    end

    def dhcp_range_start
      @record.send(options[:dhcp_range_start] || :dhcp_range_start)
    end

    def dhcp_range_stop
      @record.send(options[:dhcp_range_stop] || :dhcp_range_stop)
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
      @record.errors[:base] << (options[:message] || "The ip you provided was invalid")
    end

    def dhcp_range_error(invalid_ip)
      @record.errors[:base] << (options[:message] ||
        "The DHCP range you provided was invalid, try from #{ invalid_ip.to_range.first } to #{ invalid_ip.to_range.last }")
    end
end
