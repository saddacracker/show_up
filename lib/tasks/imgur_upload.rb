require 'rubygems'
require 'rest_client'

def imgur(key, cookie, file_path)
  url        = "http://imgur.com/api/upload.json"
  data       = {
    :key     => key, :image => File.open(file_path)
  }
  headers    = {
    :cookies => {"IMGURSESSION" => cookie}
  }
  response   = RestClient.post(url, data, headers)
  json       = JSON.parse(response.body)["rsp"]["image"] rescue nil
end
# key, IMGURSESSION cookie value, filename
imgur("f01885c6a958e51", "jtrkdk1vuifopiciil0gq11er6", "studmuffin.png")

# f01885c6a958e51 - client id
# f47a796f046d4502fdf164391b9e2f43795d520e - client secret