# MiTMProxy_Network 🌐🛡️

🔗 **GitHub Repository:** [MiTMProxy_Network](https://github.com/pentestfunctions/MiTMProxy_Network/)

## Getting Started 🚀

1. **Download and Install MiTMProxy:**  
   Visit [mitmproxy.org](https://mitmproxy.org/) to download and install MiTMProxy.

2. **Launch the Web Console:**  
   After installation, open `mitmweb` to access the web interface. It’s similar to Burp Suite and lets you monitor traffic from devices routing through your proxy.

3. **Set Up HTTPS:**  
   To ensure HTTPS is configured correctly, you need to use the provided certificate. Run the PowerShell script as an Administrator to configure the local IP for the proxy (currently set to `192.168.0.207`). Adjust this based on your local machine's IP or change it to a public IP if needed. The script will route traffic through your machine.

   You can also use the provided certificate on Android devices.

   ```powershell
   proxy_cert.ps1
   ```

Visuals 🎥

- Running the PowerShell Script:
<p align="center">
  <img src="https://github.com/pentestfunctions/MiTMProxy_Network/blob/main/images/proxy.gif">
</p>

- Accessing the Internet and Viewing Live Logs:
<p align="center">
  <img src="https://github.com/pentestfunctions/MiTMProxy_Network/blob/main/images/MiTMWeb.gif">
</p>
