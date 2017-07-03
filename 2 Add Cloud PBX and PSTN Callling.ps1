
# If you were adding Cloud PBX to E3

# Set-MsolUserLicense -UserPrincipalName tom.engagetest2@tarbuthnot.onmicrosoft.com -AddLicenses tarbuthnot:MCOEV

#To give our E5 User (Who already has Cloud PBX as part of E5 a New Microsoft PSTN phone number)

# Talk about reserving numbers
# Emergency location
# Assigning


# Three Types of number
Get-CsOnlineTelephoneNumberInventoryTypes



# Regions
Get-CsOnlineTelephoneNumberInventoryRegions -InventoryType Subscriber

# Countries

Get-CsOnlineTelephoneNumberInventoryCountries -InventoryType Subscriber -RegionalGroup EMEA

# Areas - oddly just "all" for GB

Get-CsOnlineTelephoneNumberInventoryAreas -InventoryType Subscriber -RegionalGroup EMEA -CountryOrRegion GB

# Cities

Get-CsOnlineTelephoneNumberInventoryCities -InventoryType Subscriber -RegionalGroup EMEA -CountryOrRegion GB -Area ALL | Select-Object DefaultName,ID,GeoCode,AreaCodes | Sort-Object DefaultName|  Format-Table -AutoSize

# Get a new number for this user in Reading


# How many numbers can I reserve?

Get-CsOnlineTelephoneNumberAvailableCount -InventoryType Subscriber

Get-CsOnlineTelephoneNumberAvailableCount -InventoryType Service

Get-CsOnlineTelephoneNumberAvailableCount -InventoryType TollFree


# Search for Available Numbers in Reading:

$search = Search-CsOnlineTelephoneNumberInventory -InventoryType Subscriber -RegionalGroup EMEA -CountryOrRegion GB -Area ALL -City ENG_RE -Quantity 10

$search.Reservations[0].Numbers

$ReservationResponse = Select-CsOnlineTelephoneNumberInventory -ReservationId $search.ReservationId -TelephoneNumbers $($search.Reservations[0].Numbers[0].Number) -RegionalGroup EMEA -CountryOrRegion GB -Area ALL -City ENG_RE -Verbose

# Response Object
$ReservationResponse.Items

# To release them ahead of Time (no sending object or piping on this cmdlet:

Clear-CsOnlineTelephoneNumberReservation -ReservationId $($search.ReservationId) -InventoryType Subscriber -Verbose

# Check its on my tenant
Get-CsOnlineTelephoneNumber | Select-Object InventoryType,ID,CityCode,ActivationState,FriendlyName | Sort-Object InventoryType | Format-Table


######

# "E911" / LIS Locations

Get-CsOnlineLisLocation

# New-CsOnlineLisLocation to create

##################


Get-CsOnlineVoiceUser -Identity $DemoUserUPN

Get-CsOnlineVoiceUser | Select-Object Name,UsageLocation,PSTNConnectivity,EnterpriseVoiceEnabled

# User Needs PSTN Calling

Set-MsolUserLicense -UserPrincipalName $DemoUserUPN -AddLicenses tarbuthnot:MCOPSTN2 -Verbose

Get-CsOnlineVoiceUser -Identity $DemoUserUPN

Get-MsolUser -UserPrincipalName $DemoUserUPN | fl *

# Assign user the number, note Office 365 User location, number and LocationID (LIS location) must align

$ReservationResponse.Items

# Possible lag here while licence gets replicated
Set-CsOnlineVoiceUser -Identity $DemoUserUPN -TelephoneNumber +441183702529 -LocationID c3acd1d6-434c-4fca-8966-d23b9e0616e3 -Verbose

Get-CsOnlineVoiceUser -Identity $DemoUserUPN | fl *

