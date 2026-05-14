# Configuration
$PlexIP = "192.168.1.XX"
$PlexToken = "XXXXXXXXXXXX"
$LogFile = "C:\plex_backup_log.txt"

# Build the API URL
$Url = "http://$($PlexIP):32400/butler/BackupDatabase?X-Plex-Token=$PlexToken"

# Execute the request and log the result
try {
    Invoke-RestMethod -Uri $Url -Method Post -ErrorAction Stop
    $Message = "$(Get-Date) - SUCCESS: Database backup triggered via API."
}
catch {
    $Message = "$(Get-Date) - ERROR: Failed to trigger backup. Details: $($_.Exception.Message)"
}

# Write to log file and screen
Add-Content -Path $LogFile -Value $Message
Write-Host $Message