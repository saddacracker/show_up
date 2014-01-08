ShowUp.controller "MeetingsCtrl", ($scope, Meeting) ->
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
