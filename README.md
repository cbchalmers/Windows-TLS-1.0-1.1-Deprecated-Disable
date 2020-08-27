# Project Title

Disable TLS 1.0 and 1.1 for Client and Server connections on Windows. 

## Description

Microsoft has set October 15 2020 as the date it will enforce the deprecation of legacy Transport Layer Security (TLS) web protocols TLS 1.0 and 1.1. Microsoft and other vendors have urged customers to strictly adopt TLS 1.2+ as a mitigation against possible future downgrade attacks. Nessus vulnerability scans will also highlight the use of TLS 1.0 as a risk in your environment. Following the lead of Microsoft, who spend $1 billion on cybersecurity each year, you should ensure that your Windows devices are unable to communicate on these deprecated protocols. There are a number of different ways to achieve this; deployment through Group Policy or Intune would be recommended as centralised configuration management solutions. This script is intended to be used for applying the recommendation on devices which aren't managed by Group Policy, Intune, or some other equivelant.

#### Recommendations Addressed

* TLS 1.0 Client
* TLS 1.0 Server
* TLS 1.1 Client
* TLS 1.1 Server

### Prerequisites

None

### Installing Locally

Simply run from a PowerShell session as Administrator.

### Installing with Intune

* [Microsoft Endpoint Manager Admin Center](https://devicemanagement.microsoft.com/#blade/Microsoft_Intune_DeviceSettings/DevicesMenu/powershell)
* Add > Windows 10
* Run this script using the logged on credentials = No
* Enforce script signature check = No
* Run script in 64 bit PowerShell Host = No

## Built With

* PowerShell

## References

* [Office 365: Microsoft finally retires ageing TLS 1.0 and 1.1](https://www.zdnet.com/article/office-365-microsoft-finally-retires-ageing-tls-1-0-and-1-1/)

## Authors

Chris Chalmers - [LinkedIn](https://uk.linkedin.com/in/chris-chalmers), [Azure DevOps](https://dev.azure.com/cbchalmers/Personal%20Development), [GitHub](https://github.com/cbchalmers)