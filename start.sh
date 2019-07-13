#!/bin/bash

for ctid in `vzlist -1 | awk '{print $1}'`; do
  if vzctl exec2 $ctid mysql --version | grep -q 'Ver 14.14 Distrib 5.5.'; then
     echo "Processing: "$ctid
  cat <<EOF > /vservers/private/$ctid/etc/apt/sources.list.d/mariadb.list
      deb http://mirror.klaus-uwe.me/mariadb/repo/10.0/debian jessie main
EOF

   vzctl exec2 $ctid apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
   vzctl exec2 $ctid apt-get -qq update
   vzctl exec2 $ctid DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server
   echo "done "$ctid
   fi
done


