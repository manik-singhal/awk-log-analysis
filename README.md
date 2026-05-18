# AWK Log Analysis Project

A Bash + AWK project for analyzing inconsistent web application logs using regular expressions and Linux text processing utilities.

Built as part of the **DevOps + SRE Daily Challenge Series**.

---

## Project Structure

```
awk-log-analysis/
├── process_logs.sh
├── user_activity.log
├── README.md
├── .gitignore
└── outputs/
    ├── unique_ips.txt
    ├── http_status_counts.txt
    ├── failed_logins.txt
    ├── usernames.txt
    └── summary_report.txt
```

---

## Tech Stack

| Tool | Usage |
|---|---|
| AWK | Core log processing and field extraction |
| Bash | Script automation |
| Regex | Pattern matching across log fields |
| Linux CLI | Sorting, filtering, and output handling |

---

## Tasks Performed

### Task 1 — Extract Unique IP Addresses

Loops through every field in each log line and uses regex to match IPv4 and IPv6 addresses, then deduplicates with `sort -u`.

### Task 2 — Extract Usernames

Scans each field for usernames matching the pattern `^user[0-9]+$` and stores unique results using `sort -u`.

### Task 3 — Count HTTP Status Codes

Uses `$NF` to read the last field of each line, stores counts in an AWK associative array, and prints results in the `END` block.

### Task 4 — Identify Failed Login Attempts

Filters lines where the status code is `403`, then uses `match()` and `substr()` to extract timestamps enclosed in `[]`.

### Task 5 — Generate Summary Report

Builds an overall report covering:
- Total unique users
- Requests per user
- Successful requests (`200`)
- Failed requests (`403` and `404`)

All aggregated using associative arrays and printed in the `END` block.

---

## How to Run

```bash
chmod +x process_logs.sh
./process_logs.sh
```

---

## Output Files

All reports are generated inside the `outputs/` directory:

| File | Description |
|---|---|
| `unique_ips.txt` | All unique IP addresses |
| `usernames.txt` | Extracted usernames |
| `http_status_counts.txt` | HTTP status code counts |
| `failed_logins.txt` | Failed login attempts with timestamps |
| `summary_report.txt` | Final summary report |

---

## Example Commands

```bash
# Access last field in each line
awk '{print $NF}' user_activity.log

# Filter 403 responses
awk '$NF == 403'

# Count unique users in END block
awk 'END { print length(users) }'

# Sort and deduplicate
sort -u
```

---

## Key Learnings

- AWK fundamentals and field processing
- Regex-based log parsing
- Associative arrays in AWK
- Using `match()` and `substr()` for string extraction
- Linux text processing workflows
- Real-world log analysis techniques

---

## Author

**Manik Singhal**
