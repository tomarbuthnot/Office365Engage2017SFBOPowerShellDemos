# Also Calls Organization Auto Attendant, as they started off being "AA's to access the users in the org

Get-CsOrganizationalAutoAttendant


# Service number 

# Check if there is a free service number on my tenant: (no friendly name)
Get-CsOnlineTelephoneNumber | Sort-Object InventoryType |  ft  -AutoSize


# Service Phone number
$lineUri = [System.Uri] "tel:+13022730302"

# Operator

$operatorUri = "sip:tarbuthnot.admin@tarbuthnot.onmicrosoft.com"
$operatorEntity = New-CsOrganizationalAutoAttendantCallableEntity -Identity $operatorUri -Type User

# In hours greeting

$greetingPrompt = New-CsOrganizationalAutoAttendantPrompt -TextToSpeechPrompt "Welcome to Office 365 Engage Auto Attendant"
$menuOptionZero = New-CsOrganizationalAutoAttendantMenuOption -Action TransferCallToOperator -DtmfResponse Tone0
$menuPrompt = New-CsOrganizationalAutoAttendantPrompt -TextToSpeechPrompt "To reach your party by name, enter it now, followed by the pound sign or press 0 to reach the operator."
$defaultMenu=New-CsOrganizationalAutoAttendantMenu -Name "Default menu" -Prompts @($menuPrompt) -EnableDialByName -MenuOptions @($menuOptionZero)
$defaultCallFlow = New-CsOrganizationalAutoAttendantCallFlow -Name "Default call flow" -Menu $defaultMenu -Greetings @($greetingPrompt)

# After Hours Greeting

$afterHoursGreetingPrompt = New-CsOrganizationalAutoAttendantPrompt -TextToSpeechPrompt "Welcome to Office 365 Engage! Unfortunately, you have reached us outside of our business hours. Goodbye!"
$automaticMenuOption = New-CsOrganizationalAutoAttendantMenuOption -Action Disconnect -DtmfResponse Automatic 
$afterHoursMenu=New-CsOrganizationalAutoAttendantMenu -Name "After Hours menu" -MenuOptions @($automaticMenuOption)
$afterHoursCallFlow = New-CsOrganizationalAutoAttendantCallFlow -Name "Default call flow" -Menu $afterHoursMenu -Greetings @($afterHoursGreetingPrompt)

# Define In hours and out of hours times

$timerange1 = New-CsOnlineTimeRange -Start 09:00 -end 12:00
$timerange2 = New-CsOnlineTimeRange -Start 13:00 -end 17:00
$afterHoursSchedule = New-CsOnlineSchedule -WeeklyRecurrentSchedule -MondayHours @($timerange1, $timerange2) -TuesdayHours @($timerange1, $timerange2) -WednesdayHours @($timerange1, $timerange2) -ThursdayHours @($timerange1, $timerange2) -FridayHours @($timerange1, $timerange2) -Name "After Hours Schedule" -Complement

#Define out of hours

$afterHoursCallHandlingAssociation = New-CsOrganizationalAutoAttendantCallHandlingAssociation -Type AfterHours -ScheduleId $afterHoursSchedule.Id -CallFlowId $afterHoursCallFlow.Id

$output =New-CsOrganizationalAutoAttendant -Name "Main organizational auto attendant" -LineUris @($lineUri) -DefaultCallFlow $defaultCallFlow -EnableVoiceResponse -Schedules @($afterHoursSchedule) -CallFlows @($afterHoursCallFlow) -CallHandlingAssociations @($afterHoursCallHandlingAssociation) -Language "en-us" -TimeZoneId "UTC" -Operator $operatorEntity



#Audio Files are a little different here:

# New-CsOnlineAudioFile

# $content = Get-Content "C:\Media\Welcome.wav" -Encoding byte -ReadCount 0
# $audioFile = New-CsOnlineAudioFile -FileName "Hello.wav" -Content $content
