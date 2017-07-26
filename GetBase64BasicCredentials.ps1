# -----------------------------------------------------------------------------
#  .SYNOPSIS 
# Generates a 'BASIC {encoded}' string for use as the value of the 
# AUTHORIZATION header when sending http requests.
#
# .PARAMETER username 
# The value of the username to encode.
#
# .PARAMETER password 
# The value of the password to encode.
# -----------------------------------------------------------------------------
Function Get-Base64BasicCredentials
{
    Param(
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