#!/bin/bash

log_file="user_activity.log"

mkdir -p outputs

echo "Processing log file: $log_file"

# ==========================================
# Task 1 - Extract Unique IP Addresses
# ==========================================

echo "Task 1: Extracting Unique IP Addresses..."

awk '{
    for (i=1; i<=NF; i++) {

        # IPv4
        if ($i ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ ||

        # IPv6
        ($i ~ /^[0-9a-fA-F:]+$/ && $i ~ /:/)) {

            print $i
        }
    }
}' "$log_file" | sort -u > outputs/unique_ips.txt

echo "Unique IPs saved to outputs/unique_ips.txt"


# ==========================================
# Task 2 - Extract Usernames
# ==========================================

echo "Task 2: Extracting Usernames..."

awk '
{
    for (i=1; i<=NF; i++) {

        if ($i ~ /^user[0-9]+$/) {
            print $i
        }
    }
}' "$log_file" | sort -u > outputs/usernames.txt

echo "Usernames saved to outputs/usernames.txt"


# ==========================================
# Task 3 - Count HTTP Status Codes
# ==========================================

echo "Task 3: Counting HTTP Status Codes..."

awk '{
    if ($NF != "") {
        count[$NF]++
    }
}
END {
    for (code in count) {
        print code, count[code]
    }
}' "$log_file" | sort -n > outputs/http_status_counts.txt

echo "HTTP Status Counts saved to outputs/http_status_counts.txt"


# ==========================================
# Task 4 - Failed Login Attempts
# ==========================================

echo "Task 4: Extracting Failed Login Attempts..."

awk '{
    if ($NF == 403) {

        match($0, /\[[^]]+\]/)

        print substr($0, RSTART, RLENGTH), $0
    }
}' "$log_file" > outputs/failed_logins.txt

echo "Failed login attempts saved to outputs/failed_logins.txt"


# ==========================================
# Task 5 - Generate Summary Report
# ==========================================

echo "Task 5: Generating Summary Report..."

awk '{
    for (i=1; i<=NF; i++) {

        if ($i ~ /^user[0-9]+$/) {
            users[$i]++
        }
    }

    if ($NF == 200) {
        success++
    }

    if ($NF == 403 || $NF == 404) {
        failed++
    }
}
END {

    print "Total Unique Users:", length(users)

    print "\nRequests Per User:"

    for (user in users) {
        print user, users[user]
    }

    print "\nSuccessful Requests:", success

    print "Failed Requests:", failed

}' "$log_file" > outputs/summary_report.txt

echo "Summary report saved to outputs/summary_report.txt"

echo ""
echo "All tasks completed successfully."
