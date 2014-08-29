require 'ipaddr'

class SubnetFormatValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @ip = IPAddr.new "#{ record.network_address_ip }/#{ record.subnet_mask }"
    validate_dhcp_range dhcp_start: @record.dhcp_range_start, dhcp_end: @record.dhcp_range_stop
  rescue ArgumentError
    ip_argument_error
  end
  
  private
    def validate_dhcp_range(dhcp_values)
      dhcp_start = dhcp_values[:dhcp_start]
      dhcp_end   = dhcp_values[:dhcp_end]
      
      return if dhcp_start.blank? and dhcp_end.blank?
      unless @ip.include?(dhcp_start) and @ip.include?(dhcp_end)
        dhcp_range_error
      end
    end

    def ip_argument_error
      @record.errors[:base] << (options[:message] || "is an invalid ip")
    end
    
    def dhcp_range_error
      @record.errors[:base] << (options[:message] || 
        "has an invalid DHCP range, valid range: #{ @ip.to_range.first } to #{ @ip.to_range.last }")
    end
end
