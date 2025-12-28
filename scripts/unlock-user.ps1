<#
.SYNOPSIS
Unlocks a locked Active Directory account.

.EXAMPLE
.\unlock-user.ps1 -SamAccountName jdoe
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName
)

Import-Module ActiveDirectory

try {
    Unlock-ADAccount -Identity $SamAccountName
    Write-Host "SUCCESS: Unlocked account for $SamAccountName"
}
catch {
    Write-Host "ERROR: Failed to unlock account for $SamAccountName"
    Write-Host $_.Exception.Message
}
