# -----------------------------------------------------------------------------
# Touch.ps1
#
# Contains function definitions for:
# 
# Update-FileAccessTime
#   - Updates the access date and modification date of a file or directory. If
#       the value of the $path parameter does not currently exist, an empty
#       file will be created.
#
# Contains alias definitions for:
# touch - for Update-FileAccessTime
# -----------------------------------------------------------------------------
Function Update-FileAccessTime 
{
    <#
    .SYNOPSIS
    Updates the access and modification dates for the file or directory
    specified in the $path parameter. If the object does not exist, a new
    empty file will be created. 
    
    .PARAMETER path
    The path to the file or directory object.
    
    .EXAMPLE
    Update-FileAccessTime -path {path}

    .NOTES
    This function is a behavior replication of the Unix `touch` command.
    #>
    Param(
        [Parameter(Mandatory=$true)]
        [string] $path
    )

    if (Test-Path $path) {
        (Get-ChildItem $path).LastWriteTime = Get-Date
        (Get-ChildItem $path).LastAccessTime = Get-Date
    }
    else {
        Set-Content -Path $path -Value ($null)
    }
}

# Create the alias *touch* for the Update-FileAccessTime function.
Set-Alias -Name touch -Value Update-FileAccessTime
