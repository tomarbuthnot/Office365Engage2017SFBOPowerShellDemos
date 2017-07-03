
# Sign into Office 365 and Load the SFBO PowerShell Module

# It's a script module, but you still have to install a "boot strapper"
# https://www.microsoft.com/en-us/download/details.aspx?id=39366


$Office365Creds = get-credential account@account.onmicrosoft.com

connect-msolservice -credential $Office365Creds

$SfBOsession = New-CsOnlineSession -Credential $Office365Creds

$EXOSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Office365Creds -Authentication Basic -AllowRedirection


Import-PSSession $SfBOsession
Import-PSSession $EXOSession

