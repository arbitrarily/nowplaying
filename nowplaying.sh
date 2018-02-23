 #!/bin/bash
 

 # sudo apt-get install jq curl (linux) or brew install jq (mac)
 # https://www.last.fm/api/account/create to get an API key

 old=""
 while true; do
     response=`curl -s "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=desmosthenes&api_key=API_KEY_HERE&format=json"`
     artist=`echo "$response" | jq ".[] | .track | .[0] | .artist " | tr -d "\#" | jq ".text" | tr -d '"'`
     track=`echo "$response" | jq ".[] | .track | .[0] | .name" | tr -d '"'`
     album=`echo "$response" | jq ".[] | .track | .[0] | .album " | tr -d "\#" | jq ".text" | tr -d '"'`
     new="$artist : $track ( $album )"
     if [ "$old" != "$new" ]
         then
           echo "$new"
           old="$new"
         fi
     sleep 5;
 done

