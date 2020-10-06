#!/bin/bash

# file Scripting1.sh
# brief Script that creates an HTML file using multiple functions
# author Chris Nicholas
# date 10/4/20

### functions

# check for root user
checkRoot(){
  if [ "$(id -u)" != "0"]; then
    echo "Must Run As Root" >&2
    exit 0
  fi
}

#shows Basic Info
basicInfo(){
  echo "<h2>Basic Info</h2>"
  echo "<h3>Operating System:</h3>"
  lsb_release -a
  echo "<h3>Kernel:</h3>"
  uname -r
  echo "<h3>Archetecture:</h3>"
  arch
}
#Frees the Memory
freeMemory(){
  echo "<h2>Free Memory</h2>"
  free -h
}

#Gets Disc Info
discInfo(){
  echo "<h2>Disc Information></h2>"
  lsblk
}

#Shows Assigned Group
assignedGroup(){
  echo "<h2>Group</h2>"
  groups $1
}

#Shows Ip
showIP(){
  echo "<h2>IP</h2>"
  ifconfig | grep "inet " | awk '{print $2}' 
}

#Shows Username and Timestamp
reportTitle(){
  echo "<h2>"$USER $(date)"</h2>"
}

#Show System Uptime
showUptime(){
  echo "<h2>System Uptime</h2>"
  uptime
}

#Show space in the Home Directory
homeSpace(){
  echo "<h2>Home Directory Space</h2>"
  echo "Bytes Directory"
  du -s /home/* | sort -nr
}


### Main

cat > scripting1.html <<- _EOF_
  $(checkRoot)
  <html>
    <head>
      <title>System Information</title>
      $(reportTitle)
    </head>

    <body>
      $(basicInfo)
      <br>
      $(freeMemory)
      <br>
      $(discInfo)
      <br>
      $(assignedGroup)
      <br>
      $(showIP)
      <br>
      $(showUptime)
      <br>
      $(homeSpace)
    </body>
  </html>
_EOF_
