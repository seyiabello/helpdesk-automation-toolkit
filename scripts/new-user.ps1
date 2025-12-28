<#
.SYNOPSIS
Creates a new Active Directory user in a specified OU and adds them to groups.

.EXAMPLE
.\new-user.ps1 -FirstName "Jane" -LastName "Doe" -SamAccountName "jdoe2" -OU "OU=LAB-Users,DC=lab,DC=local" -TempPassword "TempP@ss123!" -Groups @("GG-HR")
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$FirstName,

    [Parameter(Mandatory=$true)]
    [string]$LastName,

    [Parameter(Mandatory=$true)]
    [string]$SamAccountName,

    [Parameter(Mandatory=$true)]
    [string]$OU,

    [Parameter(Mandatory=$true)]
    [string]$TempPassword,

    [string[]]$Groups = @()
)

Import-Module ActiveDirectory

$DisplayName = "$FirstName $LastName"
$UPN = "$SamAccountName@lab.local"

try {
    New-ADUser `
        -Name $DisplayName `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $SamAccountName `
        -UserPrincipalName $UPN `
        -Path $OU `
        -AccountPassword (ConvertTo-SecureString $TempPassword -AsPlainText -Force) `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    foreach ($g in $Groups) {
        Add-ADGroupMember -Identity $g -Members $SamAccountName
    }

    Write-Host "SUCCESS: Created user $DisplayName ($SamAccountName) in $OU"
    if ($Groups.Count -gt 0) { Write-Host "Added to groups: $($Groups -join ', ')" }
}
catch {
    Write-Host "ERROR: Failed to create user $SamAccountName"
    Write-Host $_.Exception.Message
}
