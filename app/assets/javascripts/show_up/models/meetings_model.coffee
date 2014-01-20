ShowUp.factory "Meeting", ($resource) ->
  $resource("/meetings/:id.json", {id: "@id"}, {update: {method: "PUT"}})