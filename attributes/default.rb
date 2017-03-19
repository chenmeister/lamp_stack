def random_password
  require 'securerandom'
  SecureRandom.base64
end

default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
default['lamp_stack']['open_ports'] = 80

default['lamp_stack']['user'] = 'web_admin'
default['lamp_stack']['group'] = 'web_admin'
default['lamp_stack']['document_root'] = '/var/www/customers/public_html'

normal_unless['lamp_stack']['database']['root_password'] = random_password
normal_unless['lamp_stack']['database']['admin_password'] = random_password
default['lamp_stack']['database']['dbname'] = 'my_company'
default['lamp_stack']['database']['host'] = '127.0.0.1'
default['lamp_stack']['database']['root_username'] = 'root'
default['lamp_stack']['database']['admin_username'] = 'db_admin'