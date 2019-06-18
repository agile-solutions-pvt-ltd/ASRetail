
write-host "Press any key to continue..."
[void][System.Console]::ReadKey($true)
$AppId = [Guid]::NewGuid().Guid
$Hash = "55d3e58cec67312adbc2bb18f624fbfdf2eac8b8"

netsh http add sslcert hostname=localhost:44323 certhash=$Hash appid=`{$AppId`}
write-host "Press any key to continue..."
[void][System.Console]::ReadKey($true)