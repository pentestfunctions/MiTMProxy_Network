# Define proxy server
$proxyServer = "192.168.0.207:8080"

# Define URL and output file
$url = 'https://mitm.it/cert/cer'
$outputFile = 'mitmproxy-ca-cert.cer'

# Set proxy settings in the registry
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 1
Set-ItemProperty -Path $regPath -Name ProxyServer -Value $proxyServer
Set-ItemProperty -Path $regPath -Name AutoDetect -Value 0

# Set up proxy configuration &  Download the certificate file
$webClient = New-Object System.Net.WebClient
$proxy = New-Object System.Net.WebProxy($proxyServer)
$webClient.Proxy = $proxy
$webClient.DownloadFile($url, $outputFile)

# Import the certificate into the Trusted Root Certification Authorities store
$certPath = $outputFile
Import-Certificate -FilePath $certPath -CertStoreLocation cert:\LocalMachine\Root
