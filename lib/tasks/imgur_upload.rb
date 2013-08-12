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

imgur("your-key", "your-cookie", "/images/me.png")