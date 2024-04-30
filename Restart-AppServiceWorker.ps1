Param (
    [Parameter(Mandatory = $True, Position = 1)]
    [string]$nameofAppService,
    
    [Parameter(Mandatory = $True)]
    [string]$resourceGroupName,

    [Parameter(Mandatory = $True)]
    [string]$subscriptionId,

    [Parameter(Mandatory = $True)]
    [string]$workerName

)


try {
    Connect-AzAccount -SubscriptionId $subscriptionId
    $accessToken = Get-AzAccessToken
}
catch {
    Write-Host "Failed to connect to the Azure: $_"
}
    

$apiversion = "2022-09-01"
$url = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Web/serverfarms/$nameofAppService/workers/$workerName/reboot?api-version=$apiVersion"
$headers = @{
    "Authorization" = "Bearer $($accessToken.Token)"
    "Content-type"  = "application/json"
}
try {
    $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers
    Write-Host $response
}
catch {
    Write-Host "Failed to restart the instance: $_"
}
