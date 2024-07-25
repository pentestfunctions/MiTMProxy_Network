# Define proxy server
$proxyServer = "192.168.0.207:8080"

# Set proxy settings in the registry
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 1
Set-ItemProperty -Path $regPath -Name ProxyServer -Value $proxyServer
Set-ItemProperty -Path $regPath -Name AutoDetect -Value 0

# Define the URL and output file path
$url = "https://mitm.it/cert/cer"
$outputFilePath = "$env:USERPROFILE\Downloads\cert.cer"  # Save to Downloads folder

# Ignore SSL/TLS certificate validation
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

# Create a WebRequest object
$webRequest = [System.Net.HttpWebRequest]::Create($url)

# Set the HTTP method to GET
$webRequest.Method = "GET"

# Configure the proxy
$proxy = New-Object System.Net.WebProxy
$proxy.Address = [uri]("http://$proxyServer")
$proxy.BypassProxyOnLocal = $false
$webRequest.Proxy = $proxy

# Add the headers
$webRequest.Headers.Add("sec-ch-ua", '"Not)A;Brand";v="99", "Brave";v="127", "Chromium";v="127"')
$webRequest.Headers.Add("sec-ch-ua-mobile", "?0")
$webRequest.Headers.Add("sec-ch-ua-platform", '"Windows"')
$webRequest.Headers.Add("upgrade-insecure-requests", "1")
$webRequest.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36"
$webRequest.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8"
$webRequest.Headers.Add("sec-gpc", "1")
$webRequest.Headers.Add("Accept-Language", "en-US,en;q=0.8")
$webRequest.Headers.Add("sec-fetch-site", "same-origin")
$webRequest.Headers.Add("sec-fetch-mode", "navigate")
$webRequest.Headers.Add("sec-fetch-user", "?1")
$webRequest.Headers.Add("sec-fetch-dest", "document")
$webRequest.Referer = "https://mitm.it/"
$webRequest.Headers.Add("Accept-Encoding", "gzip, deflate, br, zstd")
$webRequest.Headers.Add("Priority", "u=0, i")

# Get the response
$response = $webRequest.GetResponse()

# Create a stream to read the response
$responseStream = $response.GetResponseStream()

# Create a file stream to write the response to a file
$fileStream = [System.IO.File]::Create($outputFilePath)

# Buffer for reading the response
$buffer = New-Object byte[] 4096
$bytesRead = 0

# Read the response stream and write to the file stream
while (($bytesRead = $responseStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
    $fileStream.Write($buffer, 0, $bytesRead)
}

# Close the streams
$responseStream.Close()
$fileStream.Close()

# Close the response
$response.Close()

Write-Host "File downloaded successfully to $outputFilePath"

# Import the certificate into the Trusted Root Certification Authorities store
Import-Certificate -FilePath $outputFilePath -CertStoreLocation cert:\LocalMachine\Root
