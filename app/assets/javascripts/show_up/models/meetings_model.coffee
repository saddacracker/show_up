ShowUp.factory "Meeting", ($resource) ->
  $resource("/meetings/:id.json"
    {id: "@id"} 
    {update: {method: "PUT"}}
    {query:  {method: "GET", params:{search:'search'}, isArray:true}}
  )
