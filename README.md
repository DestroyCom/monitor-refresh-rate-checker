# Monitor Refresh Rate Checker

## Overview

This PowerShell script checks and adjusts the refresh rate for a specified monitor. It verifies if the monitor's current refresh rate is below a desired rate, and if so, updates it to the specified value.

## Features

- **Automatic Check and Update:**
  Retrieves the current refresh rate using Get-DisplayInfo and compares it against the desired refresh rate.
- **Conditional Refresh Rate Update:**
  If the current refresh rate is below the desired value, the script updates it using Set-DisplayRefreshRate.
- **Detailed Logging:**
  Logs all actions and errors with timestamps, making it easy to verify that the script runs correctly.
- **Flexible Parameters:**
  Accepts parameters for DisplayId and DesiredRefreshRate, allowing you to schedule separate tasks for multiple monitors.

## Prerequisites

- **PowerShell 5.1 or later:** Ensure that you have PowerShell 5.1 or later installed on your system.
- **DisplayConfig 3.3.1 or later:** Download and install the DisplayConfig from PowershellGallery using the following command: `Install-Module -Name DisplayConfig` [DisplayConfig](https://www.powershellgallery.com/packages/DisplayConfig/3.3.1)

## Usage

Run the script from PowerShell by passing the required parameters:

```powershell
.\MonitorRefreshRateChecker.ps1 -DisplayId <MonitorID> -DesiredRefreshRate <RefreshRate>
```

- **DisplayId:** The ID of the monitor for which you want to check and update the refresh rate.
- **DesiredRefreshRate:** The desired refresh rate in Hz that you want to set for the monitor.

## Logging

The script logs all operations to a log file stored in the user's AppData directory.
The log file is located in `MonitorRefreshRateChecker` folder and contains detailed information about each operation, including timestamps and the result of each operation.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
