param( $configFileName)

# Some constants
$maxresultsize=3000

# Set default config file name
$defaultConfigFileName="config.ps1"

function logMsg
{
    param($message)
    Write-Output $message
}

function doSearch
{
    param($parameters)
    
    # Do the search
	logMsg("Performing search")
    $results = Search-UnifiedAuditLog @parameters
    
    # Check the results
    if( !$results -or $results.Count -eq 0 )
    {
		# Error handling code goes here...
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

logMsg("Loading config from $configFileName")
. ./$configFileName
$output = $parameters | out-string
logMsg("`nParameters: $output")

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
