# RfaOneDriveSyncMonitor
Tools to leverage the ODSyncService Module by rodneyviana for RFA public consumption. 

## How to Check for location of all users diagnostics log file
```
( new-object Net.WebClient ).DownloadString( 'https://raw.githubusercontent.com/RFAInc/RfaOneDriveSyncMonitor/main/RfaOneDriveSyncMonitor.psm1' ) | iex; Get-SyncDiagnosticsLogPath
```

