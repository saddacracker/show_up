# Geocode Gem was timing out/returning nil
# http://stackoverflow.com/questions/18285240/error-in-request-location-ruby-geocoder
Geocoder.configure(
 :timeout => 20
)