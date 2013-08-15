require 'flickraw'

FlickRaw.api_key="e825db2e351e6361c957b5243e799f61"
FlickRaw.shared_secret="ac3698ca90edbe8c"

# list   = flickr.photos.getRecent
# 
# id     = list[0].id
# secret = list[0].secret
# info = flickr.photos.getInfo :photo_id => id, :secret => secret
# 
# puts info.title           # => "PICT986"
# puts info.dates.taken     # => "2006-07-06 15:16:18"
# 
# sizes = flickr.photos.getSizes :photo_id => id
# 
# original = sizes.find {|s| s.label == 'Original' }
# puts original.width       # => "800" -- may fail if they have no original marked image


token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "Open this url in your process to complete the authication process : #{auth_url}"
puts "Copy here the number given when you complete the process."
verify = gets.strip

begin
  flickr.get_access_token(token['72157635070493099-767dcffa71507a82'], token['26-045-517'], verify)
  login = flickr.test.login
  puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
rescue FlickRaw::FailedResponse => e
  puts "Authentication failed : #{e.msg}"
end



# flickr.access_token = "72157635070493099-767dcffa71507a82"
# flickr.access_secret = "926-045-517"
# 
# # From here you are logged:
# login = flickr.test.login
# puts "You are now authenticated as #{login.username}"



# token  - 72157635070493099-767dcffa71507a82
# secret - 926-045-517



# PHOTO_PATH=ARGV[0]
# 
# # You need to be authentified to do that, see the previous examples.
# flickr.upload_photo PHOTO_PATH, :title => "Commit Snapshot", :description => "A snapshot of me when I'm commiting code, lol."