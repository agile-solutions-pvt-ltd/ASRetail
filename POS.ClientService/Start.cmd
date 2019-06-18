net stop POSService
sc delete POSService
C:\Windows\Microsoft.NET\Framework\v4.0.30319\installutil E:\Projects\POS\POS.ClientService\bin\POSService.exe
net start POSService
pause