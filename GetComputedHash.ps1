# -----------------------------------------------------------------------------
# GetComputedHash.ps1
#
# Contains function definitions for:
# 
# Get-ComputedHashForString
#   - Computes a hash for the given input string using the given algorithm.
# 
# Get-ComputedHashForFile
#   - Computes a hash for the given file using the given algorithm.
# -----------------------------------------------------------------------------
Function Get-ComputedHashForString
{
    <#
    .SYNOPSIS
    Computes a hash for the given input string using the given algorithm.
    
    .PARAMETER algorithm
    The algorithm to use when hashing.
    
    .PARAMETER input
    The string to compute the hash for.
    
    .EXAMPLE
    Get-ComputedHashForString -algorithm {md5|sha1|sha256|sha512} -input {inputstring}
    #>
    Param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet("md5", "sha1", "sha256", "sha512", IgnoreCase=$true)]
        [string] $algorithm,

        [Parameter(Mandatory=$true)]
        [string] $input
    )

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($input)
    $hasher = [System.Security.Cryptography.HashAlgorithm]::Create($algorithm)
    $hash = $hasher.ComputeHash($bytes)
    return [System.BitConverter]::ToString($hash).ToLower().Replace('-', '')
}

Function Get-ComputedHashForFile
{
    <#
    .SYNOPSIS
    Computes a hash for the given input file using the given algorithm.
    
    .PARAMETER algorithm
    The algorithm to use when hashing.
    
    .PARAMETER filepath
    The path to the file to compute the hash for.
    
    .EXAMPLE
    Get-ComputedHashForFile -algorithm {md5|sha1|sha256|sha512} -filepath {path/to/file}
    #>
    Param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet("md5", "sha1", "sha256", "sha512", IgnoreCase=$true)]
        [string] $algorithm,

        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType leaf})]
        [string] $filepath
    )

    $filestream = [System.IO.File]::OpenRead((Resolve-Path $filepath))
    $hasher = [System.Security.Cryptography.HashAlgorithm]::Create($algorithm)
    $hash = $hasher.ComputeHash($filestream)
    $filestream.Close()
    $filestream.Dispose()
    return [System.BitConverter]::ToString($hash).ToLower().Replace('-', '')
}