# How to Run These Scripts (Helpdesk Automation Toolkit)

## Requirements
- Run on DC01 or a machine with RSAT installed
- Account must have permission to manage Active Directory users
- PowerShell running as Administrator

## Enable script execution (lab only)
Run once:
```powershell
Set-ExecutionPolicy RemoteSigned
```
## Examples
### Reset password
```powershell
.\scripts\reset-password.ps1 -SamAccountName jdoe -TempPassword "TempP@ss123!"
```
### Unlock account
```powershell
.\scripts\unlock-user.ps1 -SamAccountName jdoe
```
### Create new user + add to HR group
```powershell
.\scripts\new-user.ps1 `
  -FirstName "Jane" `
  -LastName "Doe" `
  -SamAccountName "jdoe2" `
  -OU "OU=LAB-Users,DC=lab,DC=local" `
  -TempPassword "TempP@ss123!" `
  -Groups @("GG-HR")
```

---