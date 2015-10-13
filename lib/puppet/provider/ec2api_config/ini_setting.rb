Puppet::Type.type(:ec2api_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:ni_setting).provider(:ruby)
) do

  def section
    resource[:name].split('/', 2).first
  end

  def setting
    resource[:name].split('/', 2).last
  end

  def separator
    '='
  end

  def self.file_path
    '/etc/ec2api/ec2api.conf'
  end

end
