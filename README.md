# purviewPS

A Powershell script for downloading logs from Microsoft Purview.

## Setup

1. Download the script from the repository
2. Install the ExchangePowerShell module: `install-module ExchangePowerShell`
3. [optional] Download [whosIP](https://www.nirsoft.net/utils/whosip.html)

## Running the script

1. Set the parameters in the config file (`config.ps1` by default)
1. Execute `download-logs.ps1`, passing in the config file name if necessary
