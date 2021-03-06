require 'flickraw'
require 'hipchat'

FlickRaw.api_key="e825db2e351e6361c957b5243e799f61"
FlickRaw.shared_secret="ac3698ca90edbe8c"

flickr.access_token = "72157635073309787-21992ca11007e052"
flickr.access_secret = "5bf335259627714b"

PHOTO_PATH=ARGV[0]
COMMIT_MSG=ARGV[1]

# You need to be authentified to do that, see the previous examples.
# https://github.com/hanklords/flickraw
flickr.upload_photo PHOTO_PATH, :title => COMMIT_MSG, :description => "Whenever I commit code to my project, you get a snapshot"

puts "photo uploaded to flickr [()]"

# http://www.flickr.com/services/api/explore/flickr.people.getPhotos
list   = flickr.people.getPhotos :user_id => '30359366@N03'

id     = list[0].id
secret = list[0].secret
info = flickr.photos.getInfo :photo_id => id, :secret => secret

puts info.title           # => "PICT986"
puts info.dates.taken     # => "2006-07-06 15:16:18"

sizes = flickr.photos.getSizes :photo_id => id

original = sizes.find {|s| s.label == 'Original' }
puts original.source


puts "Sending to Mars Hill Hipchat..."
# https://github.com/hipchat/hipchat-rb
client = HipChat::Client.new('99351bbe8fe1c56116cd751cb81ab6')
client['Mars Hill'].send('@JohnCardwell', "<img src='#{original.source}'", :message_format => 'html', :notify => true)