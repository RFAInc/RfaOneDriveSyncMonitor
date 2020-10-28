function Get-SyncDiagnosticsLogPath {
    [CmdletBinding()]
    param()
    Resolve-Path "$($env:LOCALAPPDATA)\Microsoft\OneDrive\logs\*\SyncDiagnostics.log"
}

function Receive-OdSyncServiceSourceCode {
    [CmdletBinding()]
    param(
        [Parameter()]
        [switch]
        $PassThru
    )

    $Uri = 'https://github.com/rodneyviana/ODSyncService/archive/1.0.7542.20869.zip'
    $ModuleLeaf = Split-Path $Uri -Leaf
    $TempDir = Join-Path $env:WINDIR 'Temp'
    $ModuleParent = Join-Path $env:WINDIR 'system32\WindowsPowerShell\v1.0\Modules'
    $thisZipPath = Join-Path $TempDir $ModuleLeaf
    
    # Download the source code ZIP file
    (New-Object Net.WebClient).DownloadFile($Uri,$thisZipPath)
    
    # Extract the ZIP into a new module folder
    $thisModulePath = Join-Path $ModuleParent 'ODSyncService'
    if (Test-Path $thisModulePath) {
        Get-Item $thisModulePath | Remove-Item -Recurse -Force -Confirm:$false
    }
    New-Item -ItemType Directory -Path $thisModulePath -Force | Out-Null
	$ProgressPreference = 'SilentlyContinue'
    Expand-Archive -Path $thisZipPath -DestinationPath $thisModulePath
    $ProgressPreference = 'Continue'
	
	# Find the extracted folder name and DLL file
	$srcModulePath = Get-ChildItem $thisModulePath -Directory | Select -ExpandProperty FullName -First 1
	$dllModulePath = Join-Path $srcModulePath 'Binaries\PowerShell\OneDriveLib.dll'
	
	# Unblock the DLL
	Unblock-File -Path $dllModulePath -Confirm:$false
	
	# Return the DLL file FileIO object to the pipeline
	Get-Item $dllModulePath
}
