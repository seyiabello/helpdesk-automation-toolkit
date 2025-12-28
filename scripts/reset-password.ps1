<#
.SYNOPSIS
Resets a user's password in Active Directory and forces change at next logon.

.EXAMPLE
.\reset-password.ps1 -SamAccountName jdoe -TempPassword "TempP@ss123!"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName,

    [Parameter(Mandatory=$true)]
    [string]$TempPassword
)

Import-Module ActiveDirectory

try {
    Set-ADAccountPassword -Identity $SamAccountName -Reset `
        -NewPassword (ConvertTo-SecureString $TempPassword -AsPlainText -Force)

    Set-ADUser -Identity $SamAccountName -ChangePasswordAtLogon $true

    Write-Host "SUCCESS: Password reset for $SamAccountName and change-at-logon enabled."
}
catch {
    Write-Host "ERROR: Failed to reset password for $SamAccountName"
    Write-Host $_.Exception.Message
}
