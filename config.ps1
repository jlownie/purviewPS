# The name of the search - will be used to determine the names of the search result files
$searchName = "Default_search_name"

# The account that you will use to connect to M365
$authenticationUsername="user@domain.com"

# Set the start and end time for the audit log search
$startTime = (get-date).AddDays(-2) 
$endTime = (get-date)

$parameters = @{
    # Search constraints
    StartDate = $startTime
    EndDate = $endTime
    #UserIDs = "targetuser@domain.com"

    # Other parameters
    SessionId = $searchName
    ResultSize = $maxresultsize
    SessionCommand = "ReturnLargeSet"
}
