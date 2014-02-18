ShowUp.meetingsCtrl = ShowUp.controller "MeetingsCtrl", ($scope, $location, Meeting, AddressService) ->
  
  $scope.addressService = AddressService
  # $scope.addressService.address = $location.search().search
    
  # MEETINGS
  $scope.meetings = Meeting.query({search: $scope.addressService.address})
  
  $scope.addMeeting = ->
    # submit a POST request and trigger the create action
    meeting = Meeting.save($scope.newMeeting, () ->
      # add the entry to our list
      $scope.meetings.push(meeting)
      # store the latest new meeting
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
    

  
  # MAP
  $scope.options = {
    map: {
      center: new google.maps.LatLng(0, 0),
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
        if meeting.latitude? && meeting.longitude?
          myLatLng = new google.maps.LatLng(meeting.latitude, meeting.longitude)
          $scope.bounds.extend(myLatLng)
   
      # force it to refresh
      $scope.$broadcast 'gmMapResize', 'map-canvas'
      $scope.center = $scope.bounds.getCenter()
          
           
  
  $scope.getMeetingOpts = (meeting) ->
    angular.extend
        title: meeting.title
      , (if meeting.selected then $scope.options.selected else $scope.options.notselected) 
  
  $scope.selectMeeting = (meeting, marker) ->
    if ($scope.meeting)
      $scope.meeting.selected = false
    $scope.meeting = meeting
    $scope.meeting.selected = true;
    $scope.$broadcast 'gmMarkersUpdate', 'meetings' 
    
  $scope.selectMeetingListing = (meeting) -> 
    $scope.selectMeeting(meeting)
    $scope.center = new google.maps.LatLng(meeting.latitude, meeting.longitude)
    $scope.zoom = 17
      
  # UTILS (move to directive?)
  $scope.togglePane = () ->
    $scope.meeting.selected = !$scope.meeting.selected


    
# This has to resolve before 'meetingsCtrl' can load. 
# Right now it's just resolving itself
ShowUp.meetingsCtrl.loadData = ($q, $timeout) ->
  defer = $q.defer()
  $timeout (->
    # defer.reject "Your network is down"
    defer.resolve "loadData"
  ), 500
  defer.promise    
    
  

