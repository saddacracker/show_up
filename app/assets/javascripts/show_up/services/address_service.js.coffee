ShowUp.service "AddressService", ($location) ->  
  if $location.search().search 
    this.address = $location.search().search
  else  
    this.address = "" 
    
  
  