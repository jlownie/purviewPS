# The name of the search - will be used to determine the names of the search result files
$searchName = "Default_search_name"

# The account that you will use to connect to M365
$authenticationUsername="user@domain.com"

# Set the start and end time for the audit log search
# Note that these are in UTC

$startTime = (get-date).AddDays(-2) # Search back 2 days
#$startTime = Get-Date -Date "22/03/2024 0:0:0" # Search from a specific time

$endTime = (get-date) # Search until today

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
