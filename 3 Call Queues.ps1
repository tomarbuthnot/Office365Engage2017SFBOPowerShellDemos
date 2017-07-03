
# Calls queues AKA "Hunt Groups"


Get-CsHuntGroup

# Check if there is a free service number on my tenant: (no friendly name)
Get-CsOnlineTelephoneNumber | Sort-Object InventoryType |  ft  -AutoSize

# How do WAVE File uploads work in PowerShell?
# The MusicOnHoldFileContent parameter represents music to play when callers are placed on hold. This is the content of the audio file. Supported formats are: .wav, .mp3, and .wma. This parameter is required if the UseDefaultMusicOnHold parameter is not specified.
$c = Get-content -Path "C:\Dropbox (Personal)\Events\2017-06-17 Office 365 Engage\WelcomeToHuntGroup.wav" -Encoding Byte -ReadCount 0

[byte[]]$WAVFileContent = Get-Content -path "C:\Dropbox (Personal)\Events\2017-06-17 Office 365 Engage\WelcomeToHuntGroup.wav" -Encoding Byte -ReadCount 0


# Unified Groups or Distribution Groups
Get-UnifiedGroup
Get-DistributionGroup

# Find a Service Phone number

# Check its on my tenant
Get-CsOnlineTelephoneNumber | Select-Object InventoryType,ID,CityCode,ActivationState,FriendlyName | Sort-Object InventoryType | Format-Table


# Create Hunt Group
# Note DistributionList is looking for ExternalDirectoryObjectId (not Guid, not ExchangeGuid, not friendly name)
New-CsHuntGroup -Name "Contoso helpdesk2" -LineUri "TEL:+441213935035" -AgentAlertTime 40 -DistributionLists "f52e9a8d-28a9-44fe-b98c-66a0eb000cb0" -OverflowAction Forward -OverflowActionTarget "sip:tarbuthnot.admin@tarbuthnot.onmicrosoft.com" -OverflowThreshold 100 -TimeoutAction Forward -TimeoutActionTarget "sip:tarbuthnot.admin@tarbuthnot.onmicrosoft.com" -TimeoutThreshold 5 -WelcomeMusicFileContent $WAVFileContent -WelcomeMusicFileName "welcome1.wav" -Domain tarbuthnot.onmicrosoft.com -UseDefaultMusicOnHold $True


# To Remove
# Remove-CsHuntGroup

# To configure
# Set-CsHuntGroup