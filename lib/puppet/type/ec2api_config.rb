Puppet::Type.newtype(:ec2api_config) do

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage from ec2api.conf'
    newvalues(/\S+\/\S+/)
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined, or the key to be used in teigi.'
    unless :secret == true
      munge do |value|
        value = value.to_s.strip
        value.capitalize! if value =~ /^(true|false)$/i
        value
      end
    end

    def is_to_s( currentvalue )
      if resource.secret?
        return '[old secret redacted]'
      else
        return currentvalue
      end
    end

    def should_to_s( newvalue )
      if resource.secret?
        return '[new secret redacted]'
      else
        return newvalue
      end
    end
  end

  newparam(:secret, :boolean => true) do
    desc 'Whether to use a teigi secret as the value. Defaults to `false`.'

    newvalues(:true, :false)

    defaultto false
  end

  autorequire(:teigisecret) do
    self[:value] if self[:secret] == :true
  end
end
