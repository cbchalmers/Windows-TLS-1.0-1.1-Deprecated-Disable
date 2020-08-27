<#
# Start Logging
#>
$LogPrefix = "Log-WinTLS1011DeprecatedDisable-$Env:Computername-"
$LogDate = Get-Date -Format dd-MM-yyyy-HH-mm
$LogName = $LogPrefix + $LogDate + ".txt"
Start-Transcript -Path "C:\Windows\Temp\$LogName"

<#
# You can use the Test-Path cmdlet to check for a key, but not for specific values within a key
# Using the below function we can see if Get-ItemProperty contains the value or not, then also take different actions for data within the value
# If the value doesn't exist we will return $False, which later calls New-ItemProperty
# If the value already exists (by checking 0 or greater) we will return $True, which later calls Set-ItemProperty
#>
function Test-RegistryValue {

    param (
        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]$Path,

        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]$Name
    )

    try {
        $ItemProperty = Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Name -ErrorAction Stop
        if ($ItemProperty -eq "1") {
            return $true
        }
        else {
            return $false
        }
    }

    catch {
        return $false
    }
}

<#
# Using the below function we can create a new value (when $False) or update an existing value to 1 (when $True)
# Set-ItemProperty doesn't support -PropertyType parameter therefore can't handle both scenarios
#>
function Update-RegistryValue {

    param (
        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]$Path,

        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]$Name,

        [parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]$Exists
    )

    try {
        if ($Exists -eq $False) {
            New-ItemProperty -Path $Path -Name $Name -Value "0" -PropertyType "DWord" -ErrorAction Stop
            Write-Host "$Path\$Name has been created"
        }
        else {
            Set-ItemProperty -Path $Path -Name $Name -Value "0" -ErrorAction Stop
            Write-Host "$Path\$Name has been updated"
        }
        return $true
    }

    catch {
        return $false
    }
}

<#
# Create keys if they do not exist
# New-Item can only create a key if the higher level key exists
#>

$Paths = @("HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0", "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client", "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server", "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1", "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client", "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server")

foreach ($Path in $Paths) {
    $PathExists = Test-Path -Path $Path
    if ($PathExists -eq $False) {
        New-Item -Path $Path
    }
}

<#
# Disable TLS 1.0 Client
#>

$TLS10ClientKey = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
$TLS10ClientName = "Enabled"
$TLS10ClientExists = Test-RegistryValue -Path $TLS10ClientKey -Name $TLS10ClientName
Update-RegistryValue -Exists $TLS10ClientExists -Path $TLS10ClientKey -Name $TLS10ClientName

<#
# Disable TLS 1.0 Server
#>

$TLS10ServerKey = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
$TLS10ServerName = "Enabled"
$TLS10ServerExists = Test-RegistryValue -Path $TLS10ServerKey -Name $TLS10ServerName
Update-RegistryValue -Exists $TLS10ServerExists -Path $TLS10ServerKey -Name $TLS10ServerName

<#
# Disable TLS 1.1 Client
#>

$TLS11ClientKey = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
$TLS11ClientName = "Enabled"
$TLS11ClientExists = Test-RegistryValue -Path $TLS11ClientKey -Name $TLS11ClientName
Update-RegistryValue -Exists $TLS11ClientExists -Path $TLS11ClientKey -Name $TLS11ClientName

<#
# Disable TLS 1.1 Server
#>

$TLS11ServerKey = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
$TLS11ServerName = "Enabled"
$TLS11ServerExists = Test-RegistryValue -Path $TLS11ServerKey -Name $TLS11ServerName
Update-RegistryValue -Exists $TLS11ServerExists -Path $TLS11ServerKey -Name $TLS11ServerName

<#
# Stop Logging
#>
Stop-Transcript