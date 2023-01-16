#!/usr/bin/env bash

session="$1"

if [[ -z $session ]]; then
    echo "Please enter the flask session value from your browser cookie: "
    read -r session
fi

# If the session starts with a dot, it's compressed
if [[ $session =~ ^\..* ]]; then
    payload=$(echo $session | cut -d. -f2)
    payload="${payload}===="
    python3 -c "import base64; import zlib; print(zlib.decompress(base64.urlsafe_b64decode('$payload')))"
else
    payload=$(echo $session | cut -d. -f1)
    payload="${payload}===="
    python3 -c "import base64; print(base64.urlsafe_b64decode('$payload'))"
fi
