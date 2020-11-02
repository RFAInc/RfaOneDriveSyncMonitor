function Get-SyncDiagnosticsLogPath {
    [CmdletBinding()]
    param()
    Resolve-Path "$($env:LOCALAPPDATA)\Microsoft\OneDrive\logs\*\SyncDiagnostics.log"
}
