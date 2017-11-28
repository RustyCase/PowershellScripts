# -----------------------------------------------------------------------------
# GetBase64BasicCredentials.ps1
#
# Contains function definitions for:
# 
# Get-Base64BasicCredentials 
#   - Generates an encoded basic auth header.
# -----------------------------------------------------------------------------
Function Get-Base64BasicCredentials
{
    <#
    .SYNOPSIS
    Generates a `BASIC {encoded}` string for use as the value of the 
    AUTHORIZATION header when sending http requests.
    
    .PARAMETER username
    The value of the username to encode.
    
    .PARAMETER password
    The value of the password to encode.
    
    .EXAMPLE
    Get-Base64BasicCredentials -username {username} -password {password}
    #>

    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$username,
        [Parameter(Mandatory=$true)]
        [string]$password
    )

    $toEncode = $username + ":" + $password
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($toEncode)
    $encoded = [System.Convert]::ToBase64String($bytes)
    return "BASIC " + $encoded
}