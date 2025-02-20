#!/bin/bash

log_file="access.log"

total_requests=$(awk 'END {print NR}' "$log_file")

unique_ips=$(awk '{print $1}' "$log_file" | sort | uniq | wc -l)

get_count=$(awk '$6 ~ /"GET/ {count++} END {print count}' "$log_file")
post_count=$(awk '$6 ~ /"POST/ {count++} END {print count}' "$log_file")


popular_url=$(awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -n 1)


echo 'Result is saved in report.txt'


cat << EOF > report.txt
Report about logs of web-server
===============================

Number of requests: $total_requests

Number of unique IP: $unique_ips


Number of requests:

GET : $get_count
POST : $post_count

Most popular URL: $popular_url

===============================

EOF
