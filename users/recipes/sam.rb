users = Chef::DataBag.new
users.name('users')
users.create
sam = {
  'id' => 'sam',
  'Full Name' => 'Sammy',
  'shell' => '/bin/zsh'
}
databag_item = Chef::DataBagItem.new
databag_item.data_bag('users')
databag_item.raw_data = sam
databag_item.save

admins = data_bag('users')

admins.each do |login|
 # admin = data_bag_item('admins', login)
 # home = "/home/#{login}"

  user(login) do
    manage_home true
  end

end
