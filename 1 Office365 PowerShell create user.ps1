

$DemoUserUPN = "tom.engagetest8@account.onmicrosoft.com"

Get-MsolAccountSku

# ENTERPRISEPREMIUM – E5 Licenses
# ENTERPRISEPACK – E3 Licenses

# "MCO" is Microsoft Commuicator Online" aka SfB

# ^Engage^

New-MsolUser -DisplayName "Tom EngageTest8" -FirstName Tom -LastName EngageTest8 -UserPrincipalName $DemoUserUPN -UsageLocation GB -LicenseAssignment account:ENTERPRISEPREMIUM -PasswordNeverExpires $true -ForceChangePassword $false -Password "DemoPasswordHere!!" 
# I'm setting the password in the clear for the demo, this account will be deleted after the demo. Do not set Password Never Expires in Production, it's bad.

# Adding consupmtion billing (for select PSTN Conferencing Scenarios)
Set-MsolUserLicense -UserPrincipalName $DemoUserUPN -AddLicenses account:MCOPSTNC
# -Remove for remove