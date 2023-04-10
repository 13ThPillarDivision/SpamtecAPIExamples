# Install axios library if not already installed
if (-not(Get-Module -ListAvailable -Name 'axios')) {
    Install-Module axios -Scope CurrentUser
}

# Import required modules
Import-Module axios
Import-Module Microsoft.PowerShell.Utility

# Get user input
$userInput = Read-Host -Prompt 'Enter your input'

# Set up API URL
$apiUrl = 'https://endpoint.spamtec.cc/v1/tool?key=key&'
$params = 'input=' + [System.Uri]::EscapeDataString($userInput)
$fullUrl = $apiUrl + $params

try {
    # Send request and get response
    $response = Invoke-RestMethod -Uri $fullUrl -Method Get

    Write-Host 'API response:'
    Write-Output $response
} catch {
    Write-Error "Request failed with status code: $($_.Exception.Response.StatusCode.value__)"
}
