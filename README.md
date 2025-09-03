# Server Report Script

This script generates a server performance report including:

- CPU usage  
- Memory usage  
- Disk usage  
- Top processes  
- Logged in users  
- Failed login attempts  

It emails the report automatically via Postfix + Gmail relay.

## Usage
Run the script:
```bash
./server_report.sh
```

Or schedule it with cron for daily reports.

