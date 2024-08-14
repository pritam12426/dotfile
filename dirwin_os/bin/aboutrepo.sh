#!/usr/bin/env sh
github_url_pattern='https://github\.com/'

result=$(echo $1 | sed -E "s|$github_url_pattern||g")

data=$(curl -s "https://api.github.com/repos/$result")

# data=$(cat "linux.json")
# echo $date

# data=$(cat "linux.json")
new_data='{'

#  * Project name
new_data+='"Name":'
new_data+=$(echo $data | jq ".name")
new_data+=','

#  * Project description
new_data+='"Description":'
new_data+=$(echo $data | jq  ".description")
new_data+=','

#  * Project owner
new_data+='"Owner":'
new_data+=$(echo $data | jq  ".owner.login")
new_data+=','

#  * Project source url
new_data+='"Source":'
new_data+=$(echo $data | jq  ".html_url")
new_data+=','

#  * Project created date
new_data+='"Created":'
new_data+=$(echo $data | jq  ".created_at")
new_data+=','

#  * Project last_commit_data
new_data+='"Last commit":'
new_data+=$(echo $data | jq  ".updated_at")
new_data+=','

#  * Project size
new_data+='"Size":'
new_data+=$(echo $data | jq -r ".size")
# new_data+=','
# echo $data | jq -r ".size"

new_data+='}'
echo $new_data | jq --indent 1
