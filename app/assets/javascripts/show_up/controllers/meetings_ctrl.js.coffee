ShowUp.controller "MeetingsCtrl", ($scope, Meeting) ->
  
  # MAP
  $scope.options = {
    map: {
      center: new google.maps.LatLng(48, -121),
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
  
  $scope.togglePane = () ->
    $scope.meeting.selected = !$scope.meeting.selected
  
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
  
  
  # Meetings
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
    
    
  

