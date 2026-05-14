## Plex Database Backup Trigger

This lightweight PowerShell script utilizes the Plex "Butler" API to force an immediate database backup. It provides a reliable way to ensure your Plex metadata and database are backed up on a schedule rather than relying solely on Plex's internal maintenance window.
Plex backup default is every three days.  This script allows you to schedule daily or even multiple times a day if needed. 

---

### Core Functionality
* API-Driven: Uses the native Plex Butler API to initiate the backup process.
* Automated Logging: Records the success or failure of every backup attempt to a local log file for auditing.
* Error Handling: Utilizes a try/catch block to capture network issues, invalid tokens, or server downtime.

---

### Configuration Variables
The following variables must be set for the script to authenticate with your Plex Media Server:

| Variable | Description | Example Value |
| :--- | :--- | :--- |
| $PlexIP | The local IP address of your Plex Media Server. | 192.168.1.XXX |
| $PlexToken | Your unique Plex Authentication Token. | XXXXXXXXX... |
| $LogFile | The directory and filename for the log output. | C:\plex_backup_log.txt |
| $Url | The constructed API endpoint for the backup command. | http://[IP]:32400/butler/... |

---

### Technical Logic Overview
1. Authentication: The script appends the X-Plex-Token to the URL header, which is required for administrative API calls.
2. Butler API: It targets the `/butler/BackupDatabase` endpoint. The Butler is Plex's internal "housekeeper" that handles scheduled tasks.
3. API Method: Uses the POST method via Invoke-RestMethod. Unlike a browser refresh (GET), a POST request is required to trigger this specific action.
4. Feedback: If the server returns a 200 OK status, a success timestamp is logged. If the server is unreachable or the token is expired, the specific exception message is recorded in the log.

---

### Requirements
* OS: Windows with PowerShell 5.1 or 7+.
* Plex Media Server: Must be running and accessible via the local network.
* Plex Token: You must retrieve your token from a browser session (typically found via "View XML" on any library item).

---

### Deployment Recommendation
Because Plex usually performs backups every 3 days by default, this script allows for more frequent (daily) protection:
* Trigger: Daily (e.g., 04:00 AM).
* User Account: Can run as SYSTEM or any local user.
* Command: powershell.exe -ExecutionPolicy Bypass -File "C:\scripts\plex_backup.ps1"