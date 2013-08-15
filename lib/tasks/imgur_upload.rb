require 'flickraw'

FlickRaw.api_key="e825db2e351e6361c957b5243e799f61"
FlickRaw.shared_secret="ac3698ca90edbe8c"

flickr.access_token = "72157635073309787-21992ca11007e052"
flickr.access_secret = "5bf335259627714b"

PHOTO_PATH=ARGV[0]

# You need to be authentified to do that, see the previous examples.
flickr.upload_photo PHOTO_PATH, :title => "I totes just committed", :description => "Whenever I commit code to my project, you get a snapshot"