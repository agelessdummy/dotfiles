#alias  pup="sudo pip install --user --upgrade $(pip list --outdated --format=json | jq '.[].name' --raw-output)"   
