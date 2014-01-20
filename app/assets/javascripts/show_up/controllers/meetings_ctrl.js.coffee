ShowUp.controller "MeetingsCtrl", ($scope, Meeting) ->
  
  # MEETINGS
  $scope.meetings = Meeting.query()
  
  $scope.addMeeting = ->
    # submit a POST request and trigger the create action
    meeting = Meeting.save($scope.newMeeting, () ->
      # add the entry to our list
      $scope.meetings.push(meeting)
      $scope.newMeeting = {}
    )
  
  $scope.removeMeeting = (index) ->
    Meeting.remove({id: $scope.meetings[index].id}, () ->
      # If successful, remove it from our collection
      $scope.meetings.splice(index, 1);
    )
    
  $scope.updateMeeting = ->
    # angular.forEach $scope.meetings, (meeting) ->
      # pool.push(meeting) if !meeting.winner
    
    # When we mark an entry as a winner we need to update it in the database 
    # and we can do this by either calling Entry.update and passing in the entry
    Meeting.update(meeting)
    # or use 
    # meeting.$update()  
    

  
  # Map options
  $scope.options = {
    map: {
      center: new google.maps.LatLng(43.72651658643689, -85.25745444941401),
      zoom: 10,
      mapTypeId: google.maps.MapTypeId.ROADMAP 
    },
    notselected: {
      icon: 'https://maps.gstatic.com/mapfiles/ms2/micons/red-dot.png',
    },
    selected: {
      icon: 'https://maps.gstatic.com/mapfiles/ms2/micons/yellow-dot.png',
    }
  }
  
  
  
  $scope.$on "gmMapIdle", (event, mapId) ->
     
    
    if mapId == 'map-canvas' 
      console.log(event.name) 
      
      $scope.bounds = new google.maps.LatLngBounds()
      
      angular.forEach $scope.meetings, (meeting) ->
        if meeting.latitude?
          myLatLng = new google.maps.LatLng(meeting.latitude, meeting.longitude)
          # console.log('myLatLng: ' + myLatLng)
          $scope.bounds.extend(myLatLng)
   
      
      $scope.center = $scope.bounds.getCenter()  
      # force it to refresh
      $scope.$broadcast 'gmMapResize', 'map-canvas'
          
           
  
  $scope.getMeetingOpts = (meeting) ->
    angular.extend
        title: meeting.title
      , (if meeting.selected then $scope.options.selected else $scope.options.notselected) 
  
  $scope.selectMeeting = (meeting) ->
    if ($scope.meeting)
      $scope.meeting.selected = false
      
    $scope.meeting = meeting
    $scope.meeting.selected = true;
    $scope.$broadcast 'gmMarkersUpdate', 'meetings'  
    
  
  
  # UTILS (move to directive?)
  $scope.togglePane = () ->
    $scope.meeting.selected = !$scope.meeting.selected
    
    
  

