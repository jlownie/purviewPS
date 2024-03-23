param( $configFileName)

# Output informational messages
$InformationPreference = "Continue"

# Some constants
$maxresultsize=3000

# Set default config file name
$defaultConfigFileName="config.ps1"

function logMsg
{
    param($message)
    Write-Information $message
}

function doSearch
{
    param($parameters)
    
    # Do the search
	logMsg("Performing search")
    $results = Search-UnifiedAuditLog @parameters
    
    # Check the results
    if( !$results )
    {
		# Error handling code goes here...
	}
    if( $results.Count -eq 0 )
    {
		logMsg("Retrieved 0 records - search has completed")
	}
	else
	{
		# Do some logging
		$recordcount = $results[0].ResultCount
		logMsg("Retrieved $recordcount records")
	}
    
    return $results
}

# Load config
if( $configFileName -eq $null )
{
	$configFileName = $defaultConfigFileName
}

logMsg("`nLoading config from $configFileName")
. ./$configFileName
$output = $parameters | out-string
logMsg("`nSearch parameters: $output")

# Connect to M365
logMsg("Connecting as $authenticationUsername")
Connect-ExchangeOnline -UserPrincipalName $authenticationUsername -ShowProgress $true

# Perform the search and store the results in a variable
$results = doSearch($parameters)
$combinedresults = $results

while( $results -and $results[0].ResultCount -gt 0 )
{
    $results = doSearch($parameters)
    $combinedresults += $results
}

# Write the results to a CSV file
$resultsFileName = "$searchName.results.csv"
$combinedresults | export-csv -path $resultsFileName
